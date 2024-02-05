import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/models/patient_model.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/models/self_service_model.dart';

import './information_form_repository.dart';

class InformationFormRepositoryImpl implements InformationFormRepository {
  InformationFormRepositoryImpl({
    required this.restClient,
  });

  final RestClient restClient;
  @override
  Future<Either<RepositoryException, Unit>> register(
      SelfServiceModel model) async {
    try {
      final SelfServiceModel(
        :name!,
        :lastName!,
        patient: PatientModel(id: patientId)!,
        documents: {
          DocumentType.healthInsurenceCard: List(first: healthInsurenceCardDoc),
          DocumentType.medicalOrder: medicalOrdersDoc,
        }!
      ) = model;

      await restClient.auth.post('/patientInformationForm', data: {
        'patient_id': patientId,
        'health_insurance_card': healthInsurenceCardDoc,
        'medical_order': medicalOrdersDoc,
        'password': '$name$lastName',
        'date_created': DateTime.now().toIso8601String(),
        'status': 'Waiting',
        'tests': [],
      });

      return Right(unit);
    } on DioException catch (e, s) {
      // TODO
      log('Erro ao finalizar formulário de auto atendimento',
          error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }
}

// "patientInformationForm": [
//   {
//     "patient_information_form_id": "UUI_patient_information_form",
//     "patient_id": "UUID_PATIENT",
//     "health_insurance_card": "path_file",
//     "medical_order": [
//         "path_file",
//         "path_file"
//     ],
//     "password": "",
//     "date_created": "",
//     "date_modified": "",
//     "status_old": "Waiting | Checked In | Being Attended ",
//     "tests": [
//         {
//             "id": "UUID_XXXXX",
//             "test_id": "UUID do Exame ref table: (tests)",
//             "medical_crm": "CRM do médico",
//             "medical_name": "Nome do médico"
//         }
//     ]
//   }
// ],