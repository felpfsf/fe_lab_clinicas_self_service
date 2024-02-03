import 'package:fe_lab_clinicas_self_service_cb/src/modules/self_service/documents/documents_page.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/modules/self_service/documents/scan/documents_scan_page.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/modules/self_service/documents/scan_confirm/documents_scan_confirm_page.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/modules/self_service/done/done_page.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/modules/self_service/patient_page/patient_page.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/modules/self_service/search_patient/search_patient_router.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/modules/self_service/self_service_controller.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/modules/self_service/self_service_page.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/modules/self_service/who_i_am/who_i_am.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/repositories/patient/patient_repository.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/repositories/patient/patient_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class SelfServiceModule extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton((i) => SelfServiceController()),
        Bind.lazySingleton<PatientRepository>(
            (i) => PatientRepositoryImpl(restClient: i()))
      ];

  @override
  String get moduleRouteName => '/service';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/': (context) => const SelfServicePage(),
        '/whoIAm': (context) => const WhoIAm(),
        '/search-patient': (context) => const SearchPatientRouter(),
        '/patient': (context) => const PatientPage(),
        '/documents': (context) => const DocumentsPage(),
        '/documents-scan': (context) => const DocumentsScanPage(),
        '/documents-confirm': (context) => const DocumentsScanConfirmPage(),
        '/done': (context) => const DonePage(),
      };
}
