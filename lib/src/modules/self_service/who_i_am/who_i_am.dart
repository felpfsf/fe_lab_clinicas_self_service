import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/modules/self_service/self_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class WhoIAm extends StatefulWidget {
  const WhoIAm({super.key});

  @override
  State<WhoIAm> createState() => _WhoIAmState();
}

class _WhoIAmState extends State<WhoIAm> {
  final selfServiceController = Injector.get<SelfServiceController>();
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final lastNameEC = TextEditingController();

  void handleSubmit() {
    final valid = formKey.currentState?.validate() ?? false;
    if (valid) {
      selfServiceController.setWhoIAm(
        nameEC.text,
        lastNameEC.text,
      );
    }
  }

  @override
  void dispose() {
    nameEC.dispose();
    lastNameEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        nameEC.text = '';
        lastNameEC.text = '';
        selfServiceController.clearForm();
      },
      child: Scaffold(
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
              onSelected: (value) async {
                // Se o usuário selecionar 1 ele irá retornar para a tela de login
                // com isso removendo toda a árvore de rotas anteriores.
                if(value == 1){
                  final nav = Navigator.of(context);
                  await SharedPreferences.getInstance().then((sp) => sp.clear());
                  nav.pushNamedAndRemoveUntil('/', (route) => false);
                }
              },
            ),
          ],
        ),
        body: LayoutBuilder(
          builder: (_, constraints) {
            return SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background_login.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: const EdgeInsets.all(40),
                    width: sizeOf.width * .8,
                    decoration: BoxDecoration(
                      color: LabClinicasTheme.primaryElement,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: LabClinicasTheme.secondaryBackground),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Image(
                          image: AssetImage('assets/images/logo_vertical.png'),
                        ),
                        const SizedBox(height: 48),
                        const Text(
                          'Bem Vindo!',
                          style: LabClinicasTheme.titleStyle,
                        ),
                        const SizedBox(height: 48),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: nameEC,
                                validator: Validatorless.required(
                                    'Nome é obrigatório'),
                                decoration: const InputDecoration(
                                  label: Text('Digite seu nome'),
                                ),
                              ),
                              const SizedBox(height: 24),
                              TextFormField(
                                controller: lastNameEC,
                                validator: Validatorless.required(
                                    'Sobrenome é obrigatório'),
                                decoration: const InputDecoration(
                                  label: Text('Digite seu sobrenome'),
                                ),
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: sizeOf.width * .8,
                                height: 48,
                                child: ElevatedButton(
                                  onPressed: handleSubmit,
                                  child: const Text('CONTINUAR'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
