import 'package:brasil_fields/brasil_fields.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/modules/self_service/search_patient/search_patient_controller.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/modules/self_service/self_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

class SearchPatientPage extends StatefulWidget {
  const SearchPatientPage({super.key});

  @override
  State<SearchPatientPage> createState() => _SearchPatientPageState();
}

class _SearchPatientPageState extends State<SearchPatientPage>
    with MessageViewMixin {
  final formKey = GlobalKey<FormState>();
  final documentEC = TextEditingController();
  final controller = Injector.get<SearchPatientController>();

  void handleSubmit() {
    final valid = formKey.currentState?.validate() ?? false;

    if (valid) {
      controller.searchPatientByDocument(documentEC.text);
    }
  }

  void handleSubmitWithoutDocument() {
    controller.continueWithoutDocument();
  }

  @override
  void initState() {
    messageListener(controller);
    effect(() {
      final SearchPatientController(:patient, :patientNotFound) = controller;

      if (patient != null || patientNotFound != null) {
        // selfServiceController para redirecionar.
        Injector.get<SelfServiceController>().goToFormPatient(patient);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    documentEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Injector.get<SelfServiceController>().debugSelfService();
    final sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: LabClinicasAppbar(
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
      ),
      body: LayoutBuilder(
        builder: (_, constrains) {
          return SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                minHeight: constrains.maxHeight,
              ),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background_login.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.only(top: 112),
                  padding: const EdgeInsets.all(40),
                  width: sizeOf.width * .8,
                  decoration: BoxDecoration(
                    color: LabClinicasTheme.primaryElement,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: LabClinicasTheme.secondaryBackground,
                    ),
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Image(
                          image: AssetImage('assets/images/logo_vertical.png'),
                        ),
                        const SizedBox(height: 48),
                        TextFormField(
                          controller: documentEC,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CpfInputFormatter(),
                          ],
                          validator: Validatorless.required('CPF obrigatório'),
                          decoration: const InputDecoration(
                            label: Text('Digite CPF do Paciente'),
                          ),
                        ),
                        Row(
                          children: [
                            const Text(
                              'Não sabe seu CPF?',
                              style: TextStyle(
                                color: LabClinicasTheme.secondaryElement,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextButton(
                              onPressed: handleSubmitWithoutDocument,
                              child: const Text(
                                'Clique aqui',
                                style: TextStyle(
                                  color: LabClinicasTheme.primaryLabel,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
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
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
