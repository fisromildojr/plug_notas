import 'package:freezed_annotation/freezed_annotation.dart';

part 'prestador.freezed.dart';
part 'prestador.g.dart';

/// Entidade representando o Prestador de Serviços (NFS-e)
@freezed
class Prestador with _$Prestador {
  const factory Prestador({
    /// CPF ou CNPJ do prestador (apenas números)
    required String cpfCnpj,

    /// Razão Social ou Nome Completo
    required String razaoSocial,

    /// Inscrição Municipal (opcional)
    String? inscricaoMunicipal,

    /// Regime Tributário (opcional)
    /// 1 - Microempresa Municipal
    /// 2 - Estimativa
    /// 3 - Sociedade de Profissionais
    /// 4 - Cooperativa
    /// 5 - MEI - Simples Nacional
    /// 6 - ME EPP - Simples Nacional
    String? regimeTributario,
  }) = _Prestador;

  factory Prestador.fromJson(Map<String, dynamic> json) =>
      _$PrestadorFromJson(json);
}
