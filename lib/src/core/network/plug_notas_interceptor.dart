import 'package:dio/dio.dart';
import 'package:plug_notas/src/core/config/plug_notas_config.dart';
import 'package:plug_notas/src/core/error/exceptions.dart';

/// Interceptor para adicionar headers de autenticação e tratar erros HTTP
class PlugNotasInterceptor extends Interceptor {
  PlugNotasInterceptor(this._config);

  final PlugNotasConfig _config;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Adiciona API Key no header
    options.headers['x-api-key'] = _config.apiKey;
    options.headers['Content-Type'] = 'application/json';

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final exception = _handleDioError(err);
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: exception,
        response: err.response,
        type: err.type,
      ),
    );
  }

  /// Converte DioException em exceções tipadas do domínio
  PlugNotasException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkException(
          'Tempo de conexão esgotado. Verifique sua internet.',
        );

      case DioExceptionType.badResponse:
        return _handleHttpError(error.response);

      case DioExceptionType.cancel:
        return const UnknownException('Requisição cancelada.');

      case DioExceptionType.connectionError:
        return const NetworkException(
          'Erro de conexão. Verifique sua internet.',
        );

      case DioExceptionType.badCertificate:
        return const NetworkException(
          'Erro de certificado SSL. Conexão insegura.',
        );

      case DioExceptionType.unknown:
        return UnknownException('Erro desconhecido: ${error.message}', error);
    }
  }

  /// Trata erros HTTP baseado no status code
  PlugNotasException _handleHttpError(Response? response) {
    if (response == null) {
      return const ServerException('Resposta nula do servidor.');
    }

    final statusCode = response.statusCode ?? 0;
    final data = response.data;

    // Tenta extrair mensagem de erro do JSON de resposta da PlugNotas
    String? errorMessage;
    dynamic errorDetails;

    if (data is Map<String, dynamic>) {
      // PlugNotas retorna erros em formatos variados
      errorMessage = data['mensagem'] as String? ??
          data['message'] as String? ??
          data['error'] as String?;

      errorDetails = data['erros'] ?? data['errors'] ?? data;
    }

    switch (statusCode) {
      case 400:
        return ValidationException(
          errorMessage ?? 'Dados inválidos enviados à API.',
          errorDetails,
        );

      case 401:
        return AuthenticationException(
          errorMessage ?? 'API Key inválida ou expirada.',
        );

      case 403:
        return const AuthenticationException(
          'Acesso negado. Verifique suas permissões.',
        );

      case 404:
        return NotFoundException(errorMessage ?? 'Recurso não encontrado.');

      case 422:
        return ValidationException(
          errorMessage ?? 'Entidade não processável.',
          errorDetails,
        );

      case 429:
        return const ServerException(
          'Limite de requisições excedido. Tente novamente mais tarde.',
        );

      case 500:
      case 502:
      case 503:
      case 504:
        return ServerException(errorMessage ?? 'Erro no servidor PlugNotas.');

      default:
        return UnknownException(
          errorMessage ?? 'Erro HTTP $statusCode',
          errorDetails,
        );
    }
  }
}
