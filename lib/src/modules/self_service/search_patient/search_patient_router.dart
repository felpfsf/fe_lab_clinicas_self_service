import 'package:fe_lab_clinicas_self_service_cb/src/modules/self_service/search_patient/search_patient_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class SearchPatientRouter extends FlutterGetItModulePageRouter {
  const SearchPatientRouter({super.key});

  @override
  WidgetBuilder get view => (_) => const SearchPatientPage();
}
