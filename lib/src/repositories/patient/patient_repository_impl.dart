import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/models/patient_model.dart';

import './patient_repository.dart';

class PatientRepositoryImpl implements PatientRepository {
  PatientRepositoryImpl({
    required this.restClient,
  });

  final RestClient restClient;

  @override
  // Caso não encontrar um paciente retornar nulo, por isso o uso do ?
  Future<Either<RepositoryException, PatientModel?>> findPatientByDocument(
      String document) async {
    try {
      final Response(:List data) = await restClient.auth
          .get('/patients', queryParameters: {'document': document});

      if (data.isEmpty) {
        return Right(null);
      }

      return Right(PatientModel.fromJson(data.first));
    } on DioException catch (e, s) {
      log('Erro ao buscar pacient', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }

  @override
  Future<Either<RepositoryException, Unit>> update(PatientModel patient) async {
    try {
      await restClient.put('/patients/${patient.id}', data: patient.toJson());
      return Right(unit);
    } on DioException catch (e, s) {
      log('Erro ao atualizar paciente', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }
}
