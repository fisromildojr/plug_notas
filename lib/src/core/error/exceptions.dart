/// Classe base para todas as exceções do pacote Plug Notas
abstract class PlugNotasException implements Exception {
  const PlugNotasException(this.message, [this.details]);

  /// Mensagem principal do erro
  final String message;

  /// Detalhes adicionais sobre o erro (opcional)
  final dynamic details;

  @override
  String toString() {
    if (details != null) {
      return 'PlugNotasException: $message\nDetalhes: $details';
    }
    return 'PlugNotasException: $message';
  }
}

/// Exceção lançada quando há problemas de autenticação (401)
class AuthenticationException extends PlugNotasException {
  const AuthenticationException([String? message])
      : super(message ?? 'Falha na autenticação. Verifique sua API Key.');
}

/// Exceção lançada quando os dados enviados são inválidos (400)
class ValidationException extends PlugNotasException {
  const ValidationException(super.message, [super.details]);
}

/// Exceção lançada quando há erro no servidor da PlugNotas (500)
class ServerException extends PlugNotasException {
  const ServerException([String? message])
      : super(
          message ?? 'Erro no servidor PlugNotas. Tente novamente mais tarde.',
        );
}

/// Exceção lançada quando há problemas de conexão de rede
class NetworkException extends PlugNotasException {
  const NetworkException([String? message])
      : super(message ?? 'Erro de conexão. Verifique sua internet.');
}

/// Exceção lançada quando um recurso não é encontrado (404)
class NotFoundException extends PlugNotasException {
  const NotFoundException([String? message])
      : super(message ?? 'Recurso não encontrado.');
}

/// Exceção lançada para erros genéricos não categorizados
class UnknownException extends PlugNotasException {
  const UnknownException([String? message, dynamic details])
      : super(message ?? 'Erro desconhecido.', details);
}
