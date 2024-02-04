import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/modules/self_service/self_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class LabClinicasSelfServiceAppbar extends LabClinicasAppbar {
  LabClinicasSelfServiceAppbar({super.key})
      : super(
          actions: [
            PopupMenuButton<int>(
              child: const IconPopupMenuWidget(),
              itemBuilder: (context) {
                return [
                  const PopupMenuItem<int>(
                    value: 1,
                    child: Text('Reiniciar Processo'),
                  ),
                ];
              },
              onSelected: (value) {
                Injector.get<SelfServiceController>().restartProcess();
              },
            ),
          ],
        );
}
