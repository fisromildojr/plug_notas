import 'package:dio/dio.dart';
import 'package:plug_notas/src/core/constants/plug_notas_constants.dart';
import 'package:plug_notas/src/core/error/exceptions.dart';

/// Interface para operações remotas com a API PlugNotas
abstract class PlugNotasRemoteDataSource {
  /// Emite uma NF-e
  Future<Map<String, dynamic>> emitirNFe(Map<String, dynamic> nfeData);

  /// Emite uma NFC-e
  Future<Map<String, dynamic>> emitirNFCe(Map<String, dynamic> nfceData);

  /// Emite uma NFS-e
  Future<Map<String, dynamic>> emitirNFSe(Map<String, dynamic> nfseData);

  /// Cadastra um certificado digital
  Future<void> cadastrarCertificado(String caminhoArquivo, String senha);

  /// Consulta o status de uma nota fiscal
  Future<Map<String, dynamic>> consultarNota(String id, String tipo);
}

/// Implementação do DataSource para comunicação com API PlugNotas
class PlugNotasRemoteDataSourceImpl implements PlugNotasRemoteDataSource {
  PlugNotasRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<Map<String, dynamic>> emitirNFe(Map<String, dynamic> nfeData) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        PlugNotasConstants.nfeEndpoint,
        data: nfeData,
      );

      if (response.data == null) {
        throw const ServerException('Resposta vazia da API PlugNotas.');
      }

      return response.data!;
    } on DioException catch (e) {
      // O interceptor já converteu para PlugNotasException
      if (e.error is PlugNotasException) {
        throw e.error as PlugNotasException;
      }
      throw UnknownException('Erro ao emitir NF-e', e);
    }
  }

  @override
  Future<Map<String, dynamic>> emitirNFCe(Map<String, dynamic> nfceData) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        PlugNotasConstants.nfceEndpoint,
        data: nfceData,
      );

      if (response.data == null) {
        throw const ServerException('Resposta vazia da API PlugNotas.');
      }

      return response.data!;
    } on DioException catch (e) {
      if (e.error is PlugNotasException) {
        throw e.error as PlugNotasException;
      }
      throw UnknownException('Erro ao emitir NFC-e', e);
    }
  }

  @override
  Future<Map<String, dynamic>> emitirNFSe(Map<String, dynamic> nfseData) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        PlugNotasConstants.nfseEndpoint,
        data: nfseData,
      );

      if (response.data == null) {
        throw const ServerException('Resposta vazia da API PlugNotas.');
      }

      return response.data!;
    } on DioException catch (e) {
      if (e.error is PlugNotasException) {
        throw e.error as PlugNotasException;
      }
      throw UnknownException('Erro ao emitir NFS-e', e);
    }
  }

  @override
  Future<void> cadastrarCertificado(String caminhoArquivo, String senha) async {
    try {
      // Prepara o FormData para upload do certificado
      final formData = FormData.fromMap({
        'arquivo': await MultipartFile.fromFile(
          caminhoArquivo,
          filename: caminhoArquivo.split('/').last,
        ),
        'senha': senha,
      });

      await _dio.post(
        PlugNotasConstants.certificadoEndpoint,
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );
    } on DioException catch (e) {
      if (e.error is PlugNotasException) {
        throw e.error as PlugNotasException;
      }
      throw UnknownException('Erro ao cadastrar certificado', e);
    }
  }

  @override
  Future<Map<String, dynamic>> consultarNota(String id, String tipo) async {
    try {
      final endpoint = tipo == 'nfse'
          ? '${PlugNotasConstants.nfseEndpoint}/$id'
          : '${PlugNotasConstants.nfeEndpoint}/$id';

      final response = await _dio.get<Map<String, dynamic>>(endpoint);

      if (response.data == null) {
        throw const ServerException('Resposta vazia da API PlugNotas.');
      }

      return response.data!;
    } on DioException catch (e) {
      if (e.error is PlugNotasException) {
        throw e.error as PlugNotasException;
      }
      throw UnknownException('Erro ao consultar nota', e);
    }
  }
}
