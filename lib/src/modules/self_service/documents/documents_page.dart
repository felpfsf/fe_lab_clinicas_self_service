import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/models/self_service_model.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/modules/self_service/documents/widgets/document_box_widget.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/modules/self_service/self_service_controller.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/modules/self_service/widgets/lab_clinicas_self_service_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({super.key});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> with MessageViewMixin {
  final selfServiceController = Injector.get<SelfServiceController>();

  Future<void> handleSaveDocumen(DocumentType type) async {
    // Redireciona para a tela de scan do documento
    // A página vai retornar a url do documento qdo voltar
    final filePath =
        await Navigator.of(context).pushNamed('/service/documents/scan');
    if (filePath != null && filePath != '') {
      selfServiceController.registerDocument(
        type,
        filePath.toString(),
      );

      // Atualiza a tela com os dados novos
      setState(() {});
    }
  }

  @override
  void initState() {
    messageListener(selfServiceController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    final documents = selfServiceController.model.documents;
    final totalHealthInsuranceCards =
        documents?[DocumentType.healthInsurenceCard]?.length ?? 0;
    final totalMedicalOrders =
        documents?[DocumentType.medicalOrder]?.length ?? 0;

    return Scaffold(
      appBar: LabClinicasSelfServiceAppbar(),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.only(top: 84),
            padding: const EdgeInsets.all(32),
            width: sizeOf.width * .8,
            decoration: BoxDecoration(
              color: LabClinicasTheme.primaryElement,
              border: Border.all(
                color: LabClinicasTheme.primaryLabel,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Image.asset('assets/images/folder.png'),
                const SizedBox(height: 24),
                const Text(
                  'ADICIONAR DOCUMENTOS',
                  style: LabClinicasTheme.titleSmallStyle,
                ),
                const SizedBox(height: 32),
                const Text(
                  'Selecione o documento que deseja fotografar',
                  style: LabClinicasTheme.medium16,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: sizeOf.width * .8,
                  height: 240,
                  child: Row(
                    children: [
                      DocumentBoxWidget(
                        uploaded: totalHealthInsuranceCards > 0,
                        icon: Image.asset('assets/images/id_card.png'),
                        documentTypeLabel: 'CARTEIRINHA',
                        totalFiles: totalHealthInsuranceCards,
                        onTap: () {
                          handleSaveDocumen(DocumentType.healthInsurenceCard);
                        },
                      ),
                      const SizedBox(width: 32),
                      DocumentBoxWidget(
                        uploaded: totalMedicalOrders > 0,
                        icon: Image.asset('assets/images/document.png'),
                        documentTypeLabel: 'PEDIDO MÉDICO',
                        totalFiles: totalMedicalOrders,
                        onTap: () {
                          handleSaveDocumen(DocumentType.medicalOrder);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Visibility(
                  visible:
                      totalMedicalOrders > 0 && totalHealthInsuranceCards > 0,
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            selfServiceController.clearDocuments();
                          },
                          style: OutlinedButton.styleFrom(
                            fixedSize: const Size.fromHeight(48),
                            foregroundColor:
                                LabClinicasTheme.primarySecondaryElement,
                            side: const BorderSide(
                              color: LabClinicasTheme.primarySecondaryElement,
                            ),
                          ),
                          child: const Text('REMOVER TODAS'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size.fromHeight(48),
                            backgroundColor: LabClinicasTheme.primaryLabel,
                          ),
                          child: const Text('FINALIZAR'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
