import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:flutter/material.dart';

class DocumentBoxWidget extends StatelessWidget {
  const DocumentBoxWidget({
    super.key,
    required this.uploaded,
    required this.icon,
    required this.documentTypeLabel,
    required this.totalFiles,
    this.onTap,
  });

  final bool uploaded;
  final Widget icon;
  final String documentTypeLabel;
  final int totalFiles;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final totalFilesLabel = totalFiles > 0 ? '($totalFiles)' : '';
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: uploaded
                ? LabClinicasTheme.secondaryBackground
                : LabClinicasTheme.primaryElement,
            border: Border.all(color: LabClinicasTheme.primaryLabel),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(height: 64),
              Text(
                '$documentTypeLabel $totalFilesLabel',
                style: LabClinicasTheme.smallBold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
