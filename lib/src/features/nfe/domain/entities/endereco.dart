import 'package:freezed_annotation/freezed_annotation.dart';

part 'endereco.freezed.dart';
part 'endereco.g.dart';

/// Entidade representando um Endereço completo
@freezed
class Endereco with _$Endereco {
  const factory Endereco({
    /// Código IBGE do município (7 dígitos)
    required int codigoCidade,

    /// Nome da cidade
    required String descricaoCidade,

    /// UF (Sigla do estado com 2 letras)
    required String estado,

    /// Logradouro (Rua, Avenida, etc.)
    required String logradouro,

    /// Número do imóvel
    required String numero,

    /// Bairro
    required String bairro,

    /// CEP (apenas números)
    required String cep,

    /// Complemento (opcional)
    String? complemento,
  }) = _Endereco;

  factory Endereco.fromJson(Map<String, dynamic> json) =>
      _$EnderecoFromJson(json);
}
