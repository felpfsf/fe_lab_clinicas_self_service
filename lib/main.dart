import 'dart:async';
import 'dart:developer';

import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/binding/lab_clinicas_application_binding.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/modules/auth/auth_module.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/modules/home/home_module.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/pages/splash_page/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

void main() {
  // Criando uma zone de erros
  runZonedGuarded(() => runApp(const LabClinicasSelfServiceApp()),
      (error, stack) {
    log("Erro não tratado", error: error, stackTrace: stack);
  });
}

class LabClinicasSelfServiceApp extends StatelessWidget {
  const LabClinicasSelfServiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LabClinicasCoreConfig(
      title: 'Lab Clinicas Auto Atendimento',
      binding: LabClinicasApplicationBinding(),
      pagesBuilder: [
        FlutterGetItPageBuilder(
          page: (_) => const SplashPage(),
          path: '/',
        )
      ],
      modules: [
        AuthModule(),
        HomeModule(),
      ],
    );
  }
}
