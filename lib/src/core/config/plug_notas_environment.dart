/// Enum que define os ambientes disponíveis da API PlugNotas
enum PlugNotasEnvironment {
  /// Ambiente de testes/desenvolvimento
  sandbox('https://api.sandbox.plugnotas.com.br'),

  /// Ambiente de produção
  production('https://api.plugnotas.com.br');

  const PlugNotasEnvironment(this.baseUrl);

  /// URL base da API para o ambiente selecionado
  final String baseUrl;
}
