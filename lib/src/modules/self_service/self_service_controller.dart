import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/models/patient_model.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/models/self_service_model.dart';
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
  // Inicia como vazio
  final _step = ValueSignal(FormSteps.none);
  var _model = const SelfServiceModel();

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
    print(
        "🚀 ~ SelfServiceController ~ goToFormPatient ~ model ~ ${_model.patient?.name}");
    _step.forceUpdate(FormSteps.patient);
  }

  void restartProcess() {
    _step.forceUpdate(FormSteps.restart);
    clearForm();
  }
}
