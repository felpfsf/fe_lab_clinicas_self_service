import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/models/patient_model.dart';

abstract interface class PatientRepository {
  // Caso não encontrar um paciente retornar nulo, por isso o uso do ?
  Future<Either<RepositoryException, PatientModel?>> findPatientByDocument(
      String document);

  Future<Either<RepositoryException, Unit>> update(PatientModel patient);
}
