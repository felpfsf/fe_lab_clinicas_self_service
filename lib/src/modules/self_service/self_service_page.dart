import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/modules/self_service/self_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:signals_flutter/signals_flutter.dart';

class SelfServicePage extends StatefulWidget {
  const SelfServicePage({super.key});

  @override
  State<SelfServicePage> createState() => _SelfServicePageState();
}

class _SelfServicePageState extends State<SelfServicePage>
    with MessageViewMixin {
  final controller = Injector.get<SelfServiceController>();

  @override
  void initState() {
    messageListener(controller);
    // Espera a tela compilar para ter acesso ao context e então direcionar para as rotas
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.startProcess();
      effect(() {
        String baseRoute = '/service/';
        final step = controller.step;

        switch (step) {
          case FormSteps.none:
            return;
          case FormSteps.whoIAm:
            baseRoute += 'whoIAm';
          case FormSteps.searchPatient:
            baseRoute += 'search-patient';
          case FormSteps.patient:
            baseRoute += 'patient';
          case FormSteps.documents:
            baseRoute += 'documents';
          case FormSteps.done:
            baseRoute += 'done';
          case FormSteps.restart:
            return;
        }
        // Com base nos enums da controller foi feito o switch acima,
        // ele vai definir a proxima rota qdo o usuário trocar de passo no formulário
        Navigator.of(context).pushNamed(baseRoute);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
