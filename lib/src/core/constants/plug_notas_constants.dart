/// Constantes utilizadas no pacote Plug Notas
class PlugNotasConstants {
  PlugNotasConstants._();

  // Endpoints da API PlugNotas
  static const String nfeEndpoint = '/nfe';
  static const String nfceEndpoint = '/nfce';
  static const String nfseEndpoint = '/nfse';
  static const String certificadoEndpoint = '/certificado';

  // Timeout padrão para requisições (em milissegundos)
  static const int connectTimeout = 30000; // 30 segundos
  static const int receiveTimeout = 30000; // 30 segundos
  static const int sendTimeout = 30000; // 30 segundos

  // Headers
  static const String apiKeyHeader = 'x-api-key';
  static const String contentTypeHeader = 'Content-Type';
  static const String contentTypeJson = 'application/json';

  // Meios de Pagamento (NF-e)
  static const String pagamentoDinheiro = '01';
  static const String pagamentoCheque = '02';
  static const String pagamentoCartaoCredito = '03';
  static const String pagamentoCartaoDebito = '04';
  static const String pagamentoCreditoLoja = '05';
  static const String pagamentoValeAlimentacao = '10';
  static const String pagamentoValeRefeicao = '11';
  static const String pagamentoValePresente = '12';
  static const String pagamentoValeCombustivel = '13';
  static const String pagamentoBoleto = '15';
  static const String pagamentoPix = '17';
  static const String pagamentoSemPagamento = '90';
  static const String pagamentoOutro = '99';
}
