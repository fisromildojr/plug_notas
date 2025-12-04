import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagamento.freezed.dart';
part 'pagamento.g.dart';

/// Entidade representando uma forma de Pagamento da NF-e
@freezed
class Pagamento with _$Pagamento {
  const factory Pagamento({
    /// Meio de pagamento
    /// Valores possíveis:
    /// - '01': Dinheiro
    /// - '02': Cheque
    /// - '03': Cartão de Crédito
    /// - '04': Cartão de Débito
    /// - '05': Crédito Loja
    /// - '10': Vale Alimentação
    /// - '11': Vale Refeição
    /// - '12': Vale Presente
    /// - '13': Vale Combustível
    /// - '15': Boleto Bancário
    /// - '17': PIX
    /// - '90': Sem pagamento
    /// - '99': Outros
    required String meio,

    /// Valor do pagamento
    required double valor,

    /// Tipo de integração (opcional)
    /// '1': Pagamento integrado
    /// '2': Pagamento não integrado
    @Default('2') String tipoIntegracao,

    /// CNPJ da credenciadora (opcional, obrigatório para cartões)
    String? cnpjCredenciadora,

    /// Bandeira da operadora (opcional, obrigatório para cartões)
    /// Ex: '01' - Visa, '02' - Mastercard, '03' - American Express, etc.
    String? bandeiraOperadora,

    /// Número de autorização (opcional)
    String? numeroAutorizacao,
  }) = _Pagamento;

  factory Pagamento.fromJson(Map<String, dynamic> json) =>
      _$PagamentoFromJson(json);
}
