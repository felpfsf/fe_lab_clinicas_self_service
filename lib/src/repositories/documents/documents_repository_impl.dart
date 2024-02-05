import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';

import './documents_repository.dart';

class DocumentsRepositoryImpl implements DocumentsRepository {
  const DocumentsRepositoryImpl({
    required this.restClient,
  });

  final RestClient restClient;
  @override
  Future<Either<RepositoryException, String>> uploadImage(
      Uint8List file, String filename) async {
    try {
      final formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(file, filename: filename),
      });

      final Response(data: {'url': pathImage}) =
          await restClient.auth.post('/uploads', data: formData);

      return Right(pathImage);
    } on DioException catch (e, s) {
      log('Erro ao fazer upload de imagem', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }
}
