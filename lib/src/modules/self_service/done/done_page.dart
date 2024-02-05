import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:flutter/material.dart';

class DonePage extends StatelessWidget {
  const DonePage({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: LabClinicasAppbar(),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: sizeOf.width * .8,
            margin: const EdgeInsets.only(top: 84),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: LabClinicasTheme.primaryElement,
              border: Border.all(color: LabClinicasTheme.primaryLabel),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Image.asset('assets/images/stroke_check.png'),
                const SizedBox(height: 24),
                const Text(
                  'Sua senha é',
                  style: LabClinicasTheme.titleSmallStyle,
                ),
                const SizedBox(height: 24),
                Container(
                  width: sizeOf.width * .4,
                  padding:
                      const EdgeInsets.symmetric(vertical: 9, horizontal: 60),
                  decoration: BoxDecoration(
                    color: LabClinicasTheme.primaryLabel,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    'BG5898',
                    style: LabClinicasTheme.titleSmallBoldStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'AGUARDE!',
                  style: LabClinicasTheme.bodyBold18Style,
                ),
                const Text(
                  'Sua senha será chamado no painel',
                  style: LabClinicasTheme.bodyBold18Style,
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size.fromHeight(48),
                        ),
                        child: const Text('IMPRIMIR SENHA'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          fixedSize: const Size.fromHeight(48),
                        ),
                        child: const Text(
                          'ENVIAR SENHA VIA SMS',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: LabClinicasTheme.primaryLabel,
                    ),
                    onPressed: () {},
                    child: const Text('FINALIZAR'),
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
