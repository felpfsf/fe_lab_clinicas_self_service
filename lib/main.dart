import 'dart:async';
import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/binding/lab_clinicas_application_binding.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/modules/auth/auth_module.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/modules/home/home_module.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/modules/self_service/self_service_module.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/pages/splash_page/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

late List<CameraDescription> _cameras;

void main() async {
  // Criando uma zone de erros
  runZonedGuarded(() async {
    // Inicializando o package de camera
    WidgetsFlutterBinding.ensureInitialized();
    _cameras = await availableCameras();

    runApp(const LabClinicasSelfServiceApp());
  }, (error, stack) {
    log("Erro não tratado", error: error, stackTrace: stack);
    throw error;
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
        SelfServiceModule(),
      ],
      didStart: (){
        // Recurso que é utilizado para registar as cameras
        // ele é registrado globalmente através de uma key
        FlutterGetItBindingRegister.registerPermanentBinding('CAMERAS', [
          Bind.lazySingleton((i) => _cameras)
        ]);
      },
    );
  }
}
