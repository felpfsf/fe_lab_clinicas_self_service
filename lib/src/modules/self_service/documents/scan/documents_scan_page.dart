import 'package:asyncstate/asyncstate.dart';
import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class DocumentsScanPage extends StatefulWidget {
  const DocumentsScanPage({super.key});

  @override
  State<DocumentsScanPage> createState() => _DocumentsScanPageState();
}

class _DocumentsScanPageState extends State<DocumentsScanPage> {
  late CameraController cameraController;

  @override
  void initState() {
    cameraController = CameraController(
      Injector.get<List<CameraDescription>>().first,
      ResolutionPreset.ultraHigh,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: LabClinicasAppbar(),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.only(top: 42),
            padding: const EdgeInsets.all(32),
            width: sizeOf.width * .8,
            decoration: BoxDecoration(
              color: LabClinicasTheme.primaryElement,
              border: Border.all(color: LabClinicasTheme.primaryLabel),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Image.asset('assets/images/cam_icon.png'),
                const SizedBox(height: 24),
                const Text(
                  'TIRE A FOTO AGORA',
                  style: LabClinicasTheme.titleSmallStyle,
                ),
                const SizedBox(height: 32),
                const Text(
                  'Posicione o documento dentro do quadrado abaixo e aperte o botão para tirar a foto',
                  style: LabClinicasTheme.medium16,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                FutureBuilder(
                  future: cameraController.initialize(),
                  builder: (context, snapshop) {
                    switch (snapshop) {
                      case AsyncSnapshot(
                          connectionState:
                              ConnectionState.waiting || ConnectionState.active
                        ):
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case AsyncSnapshot(connectionState: ConnectionState.done):
                        if (cameraController.value.isInitialized) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: SizedBox(
                              width: sizeOf.width * .35,
                              child: CameraPreview(
                                cameraController,
                                child: DottedBorder(
                                  dashPattern: const [1, 10, 1, 3],
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(16),
                                  strokeWidth: 4,
                                  strokeCap: StrokeCap.square,
                                  color: LabClinicasTheme.primaryLabel,
                                  child: const SizedBox.expand(),
                                ),
                              ),
                            ),
                          );
                        }
                    }
                    return const Center(
                      child: Text(
                        'Erro ao carregar a câmera',
                        style: LabClinicasTheme.titleSmallStyle,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () async {
                      final nav = Navigator.of(context);
                      final foto =
                          await cameraController.takePicture().asyncLoader();
                      nav.pushNamed(
                        '/service/documents/confirm',
                        arguments: foto,
                      );
                    },
                    child: const Text('TIRAR FOTO'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
