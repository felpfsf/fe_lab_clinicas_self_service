import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/modules/self_service/self_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class SearchPatientPage extends StatelessWidget {
  const SearchPatientPage({super.key});

  @override
  Widget build(BuildContext context) {
    Injector.get<SelfServiceController>().debugSelfService();
    return Scaffold(
      appBar: LabClinicasAppbar(
        actions: [
          PopupMenuButton<int>(
            child: const IconPopupMenuWidget(),
            itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text('Finalizar Terminal'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Container(),
    );
  }
}
