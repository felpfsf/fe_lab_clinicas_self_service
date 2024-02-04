import 'package:brasil_fields/brasil_fields.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/modules/self_service/patient_page/patient_form_controller.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/modules/self_service/widgets/lab_clinicas_self_service_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:validatorless/validatorless.dart';

class PatientPage extends StatefulWidget {
  const PatientPage({super.key});

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> with PatientFormController {
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    disposeForm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: LabClinicasSelfServiceAppbar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Container(
            width: sizeOf.width * .85,
            margin: const EdgeInsets.only(top: 18),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: LabClinicasTheme.primaryElement,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset('assets/images/check_icon.png'),
                  const SizedBox(height: 24),
                  const Text(
                    'Cadastro Encontrado',
                    style: LabClinicasTheme.titleSmallStyle,
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Confirma os dados do seu cadastro',
                    style: LabClinicasTheme.medium16,
                  ),
                  const SizedBox(height: 24),
                  Column(
                    children: [
                      TextFormField(
                        controller: nameEC,
                        validator: Validatorless.required('Nome obrigatório'),
                        decoration: const InputDecoration(
                          label: Text('Nome do paciente'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: emailEC,
                        validator: Validatorless.multiple([
                          Validatorless.required('E-mail obrigatório'),
                          Validatorless.email('E-mail inválido'),
                        ]),
                        decoration: const InputDecoration(
                          label: Text('Email'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: phoneEC,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter(),
                        ],
                        validator:
                            Validatorless.required('Telefone obrigatório'),
                        decoration: const InputDecoration(
                          label: Text('Telefone de contato'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: documentEC,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CpfInputFormatter(),
                        ],
                        validator: Validatorless.required('CPF obrigatório'),
                        decoration: const InputDecoration(
                          label: Text('CPF'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: zipCodeEC,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CepInputFormatter(),
                        ],
                        validator: Validatorless.required('CPF obrigatório'),
                        decoration: const InputDecoration(
                          label: Text('CEP'),
                          suffixIcon: Icon(
                            Icons.search,
                            size: 32,
                            color: LabClinicasTheme.primaryLabel,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            flex: 3,
                            child: TextFormField(
                              controller: streetEC,
                              validator: Validatorless.required(
                                  'Endereço obrigatório'),
                              decoration: const InputDecoration(
                                label: Text('Endereço'),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Flexible(
                            child: TextFormField(
                              validator:
                                  Validatorless.required('Número obrigatório'),
                              controller: numberEC,
                              decoration: const InputDecoration(
                                label: Text('Número'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: complementEC,
                              decoration: const InputDecoration(
                                label: Text('Complemento'),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: stateEC,
                              validator:
                                  Validatorless.required('Estado obrigatório'),
                              decoration: const InputDecoration(
                                label: Text('Estado'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: cityEC,
                              validator:
                                  Validatorless.required('Cidade obrigatória'),
                              decoration: const InputDecoration(
                                label: Text('Cidade'),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              validator:
                                  Validatorless.required('Bairro obrigatório'),
                              controller: districtEC,
                              decoration: const InputDecoration(
                                label: Text('Bairro'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: guardianEC,
                        decoration: const InputDecoration(
                          label: Text('Responsável'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: guardianIdentificationNumberEC,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CepInputFormatter(),
                        ],
                        decoration: const InputDecoration(
                          label: Text('Documento de identificação'),
                        ),
                      ),
                      const SizedBox(height: 42),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: OutlinedButton(
                                onPressed: () {},
                                child: const Text('EDITAR'),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const Text('CONTINUAR'),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
