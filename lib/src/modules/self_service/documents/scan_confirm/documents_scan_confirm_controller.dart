import 'dart:typed_data';

import 'package:asyncstate/asyncstate.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service_cb/src/repositories/documents/documents_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

class DocumentsScanConfirmController with MessageStateMixin {
  DocumentsScanConfirmController({
    required this.documentsRepository,
  });

  final pathRemoteStorage = signal<String?>(null);
  final DocumentsRepository documentsRepository;

  Future<void> uploadImage(Uint8List imgBytes, String filename) async {
    final result =
        await documentsRepository.uploadImage(imgBytes, filename).asyncLoader();

    switch (result) {
      case Left():
        showError('Erro ao fazer upload da image');
      case Right(value: final filePath):
        pathRemoteStorage.value = filePath;
    }
  }
}
