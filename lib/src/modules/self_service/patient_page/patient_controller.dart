import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/models/patient_model.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/repositories/patient/patient_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

class PatientController with MessageStateMixin {
  PatientController({
    required PatientRepository repository,
  }) : _repository = repository;

  PatientModel? patient;
  final PatientRepository _repository;
  final _nextStep = signal<bool>(false);

  bool get nextStep => _nextStep();

  void goNextStep() {
    _nextStep.value = true;
  }

  Future<void> saveAndNext(RegisterPatientModel model) async {
    final result = await _repository.create(model);

    switch (result) {
      case Left():
        showError('Erro ao cadastrar paciente, chame um atendente');
      case Right(value: final newPatient):
        showSuccess('Paciente cadastrado com sucesso');
        patient = newPatient;
        goNextStep();
    }
  }

  Future<void> updateAndNext(PatientModel model) async {
    final updateResult = await _repository.update(model);

    switch (updateResult) {
      case Left():
        showError('Erro ao atualizar dados, chame um atendente');
      case Right():
        showInfo('Paciente atualizado com sucesso');
        patient = model;
        goNextStep();
    }
  }
}
