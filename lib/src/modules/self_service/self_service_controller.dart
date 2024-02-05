import 'package:asyncstate/asyncstate.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/models/patient_model.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/models/self_service_model.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/repositories/information_form/information_form_repository.dart';
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

enum FormSteps {
  none,
  whoIAm,
  searchPatient,
  patient,
  documents,
  done,
  restart,
}

class SelfServiceController with MessageStateMixin {
  SelfServiceController({
    required this.informationFormRepository,
  });

  final InformationFormRepository informationFormRepository;
  // Inicia como vazio
  final _step = ValueSignal(FormSteps.none);
  var _model = const SelfServiceModel();
  String password = '';

  FormSteps get step => _step();
  SelfServiceModel get model => _model;

  void startProcess() {
    _step.forceUpdate(FormSteps.whoIAm);
  }

  void setWhoIAm(String name, String lastName) {
    _model = _model.copyWith(name: () => name, lastName: () => lastName);
    _step.forceUpdate(FormSteps.searchPatient);
  }

  void debugSelfService() {
    debugPrint('debugSelfService ${_model.name} ${_model.lastName}');
  }

  void clearForm() {
    _model = _model.clear();
  }

  void goToFormPatient(PatientModel? patient) {
    _model = _model.copyWith(patient: () => patient);
    _step.forceUpdate(FormSteps.patient);
  }

  void restartProcess() {
    _step.forceUpdate(FormSteps.restart);
    clearForm();
  }

  void updatePatientAndGoDocument(PatientModel? patient) {
    _model = _model.copyWith(patient: () => patient);
    _step.forceUpdate(FormSteps.documents);
  }

  void registerDocument(DocumentType type, String filePath) {
    final documents = _model.documents ?? {};

    if (type == DocumentType.healthInsurenceCard) {
      // Só pode ter uma única carterinha de convênio
      documents[type]?.clear();
    }

    final values = documents[type] ?? [];
    values.add(filePath);
    documents[type] = values;
    _model = _model.copyWith(documents: () => documents);
  }

  void clearDocuments() {
    _model = _model.copyWith(documents: () => {});
  }

  Future<void> finalize() async {
    final result =
        await informationFormRepository.register(model).asyncLoader();

    switch (result) {
      case Left():
        showError('Erro ao registrar atendimento');
      case Right():
        password = '${_model.name}${_model.lastName}';
        _step.forceUpdate(FormSteps.done);
        showSuccess('Atendimento finalizado com sucesso');
    }
  }
}
