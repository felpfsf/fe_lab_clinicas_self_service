import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/models/patient_model.dart';

typedef RegisterPatientAddressModel = ({
  String cep,
  String streetAddress,
  String number,
  String addressComplement,
  String state,
  String city,
  String district,
});

typedef RegisterPatientModel = ({
  String name,
  String email,
  String document,
  String phoneNumber,
  RegisterPatientAddressModel address,
  String guardian,
  String guardianIdentificationNumber,
});

abstract interface class PatientRepository {
  // Caso não encontrar um paciente retornar nulo, por isso o uso do ?
  Future<Either<RepositoryException, PatientModel?>> findPatientByDocument(
      String document);

  Future<Either<RepositoryException, Unit>> update(PatientModel patient);

  Future<Either<RepositoryException, PatientModel>> create(RegisterPatientModel patient);
}
