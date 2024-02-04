import 'package:fe_lab_clinicas_self_service_cb/src/models/patient_model.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/modules/self_service/patient_page/patient_page.dart';
import 'package:flutter/material.dart';

mixin PatientFormController on State<PatientPage> {
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final phoneEC = TextEditingController();
  final documentEC = TextEditingController();
  final zipCodeEC = TextEditingController();
  final streetEC = TextEditingController();
  final numberEC = TextEditingController();
  final complementEC = TextEditingController();
  final stateEC = TextEditingController();
  final cityEC = TextEditingController();
  final districtEC = TextEditingController();
  final guardianEC = TextEditingController();
  final guardianIdentificationNumberEC = TextEditingController();

  void disposeForm() {
    nameEC.dispose();
    emailEC.dispose();
    phoneEC.dispose();
    documentEC.dispose();
    zipCodeEC.dispose();
    streetEC.dispose();
    numberEC.dispose();
    complementEC.dispose();
    stateEC.dispose();
    cityEC.dispose();
    districtEC.dispose();
    guardianEC.dispose();
    guardianIdentificationNumberEC.dispose();
  }

  void initializeForm(final PatientModel? patient) {
    if (patient != null) {
      nameEC.text = patient.name;
      emailEC.text = patient.email;
      phoneEC.text = patient.phoneNumber;
      documentEC.text = patient.document;
      zipCodeEC.text = patient.address.cep;
      streetEC.text = patient.address.streetAddress;
      numberEC.text = patient.address.number;
      complementEC.text = patient.address.addressComplement;
      stateEC.text = patient.address.state;
      cityEC.text = patient.address.city;
      districtEC.text = patient.address.district;
      guardianEC.text = patient.guardian;
      guardianIdentificationNumberEC.text =
          patient.guardianIdentificationNumber;
    }
  }
}
