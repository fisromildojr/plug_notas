import 'package:plug_notas/src/core/config/plug_notas_environment.dart';

/// Configuração Singleton do pacote Plug Notas
///
/// Gerencia as configurações globais como API Key e ambiente de execução
class PlugNotasConfig {
  PlugNotasConfig._internal();

  static final PlugNotasConfig _instance = PlugNotasConfig._internal();

  /// Obtém a instância única do PlugNotasConfig
  factory PlugNotasConfig() => _instance;

  String? _apiKey;
  PlugNotasEnvironment? _environment;

  /// API Key fornecida pela PlugNotas
  String get apiKey {
    if (_apiKey == null) {
      throw StateError(
        'PlugNotasConfig não inicializado. '
        'Chame PlugNotas.initialize() primeiro.',
      );
    }
    return _apiKey!;
  }

  /// Ambiente atual (sandbox ou production)
  PlugNotasEnvironment get environment {
    if (_environment == null) {
      throw StateError(
        'PlugNotasConfig não inicializado. '
        'Chame PlugNotas.initialize() primeiro.',
      );
    }
    return _environment!;
  }

  /// URL base da API baseada no ambiente configurado
  String get baseUrl => environment.baseUrl;

  /// Inicializa as configurações do pacote
  void initialize({
    required String apiKey,
    required PlugNotasEnvironment environment,
  }) {
    _apiKey = apiKey;
    _environment = environment;
  }

  /// Verifica se o pacote foi inicializado
  bool get isInitialized => _apiKey != null && _environment != null;

  /// Reseta as configurações (útil para testes)
  void reset() {
    _apiKey = null;
    _environment = null;
  }
}
