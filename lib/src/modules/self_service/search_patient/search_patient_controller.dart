import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/models/patient_model.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/repositories/patient/patient_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

class SearchPatientController with MessageStateMixin {
  SearchPatientController({
    required PatientRepository patientRepository,
  }) : _patientRepository = patientRepository;

  final PatientRepository _patientRepository;
  final _patientNotFound = ValueSignal<bool?>(null);
  final _patient = ValueSignal<PatientModel?>(null);

  bool? get patientNotFound => _patientNotFound();
  PatientModel? get patient => _patient();

  void searchPatientByDocument(String document) async {
    final patientResult =
        await _patientRepository.findPatientByDocument(document);

    bool patientNotFound;
    PatientModel? patient;

    switch (patientResult) {
      case Right(value: PatientModel model?):
        patientNotFound = false;
        patient = model;
      case Right(value: _):
        patientNotFound = true;
        patient = null;
      case Left():
        showError('Erro ao buscar paciente');
        return;
    }
    // Envia em lote as alterações do estado assim evita problemas
    // no effect()
    batch(() {
      _patient.value = patient;
      _patientNotFound.value = patientNotFound;
    });
  }

  void continueWithoutDocument() {
    batch(() {
      _patient.value = null;
      _patientNotFound.value = true;
    });
  }
}
