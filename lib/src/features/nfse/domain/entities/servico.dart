import 'package:freezed_annotation/freezed_annotation.dart';

part 'servico.freezed.dart';
part 'servico.g.dart';

/// Entidade representando o Serviço prestado (NFS-e)
@freezed
class Servico with _$Servico {
  const factory Servico({
    /// Código do serviço na lista de serviços do município
    required String codigo,

    /// Discriminação/descrição detalhada do serviço
    required String discriminacao,

    /// CNAE - Classificação Nacional de Atividades Econômicas
    required String cnae,

    /// Valor total do serviço
    required double valorServico,

    /// Informações do ISS (Imposto Sobre Serviços)
    required ISS iss,

    /// Alíquota de PIS (opcional)
    double? aliquotaPis,

    /// Alíquota de COFINS (opcional)
    double? aliquotaCofins,

    /// Valor de deduções (opcional)
    double? valorDeducoes,

    /// Valor de descontos (opcional)
    double? valorDescontos,
  }) = _Servico;

  factory Servico.fromJson(Map<String, dynamic> json) =>
      _$ServicoFromJson(json);
}

/// ISS - Imposto Sobre Serviços
@freezed
class ISS with _$ISS {
  const factory ISS({
    /// Alíquota do ISS (percentual)
    required double aliquota,

    /// Valor do ISS
    required double valor,

    /// Exigibilidade do ISS (opcional)
    /// 1 - Exigível
    /// 2 - Não incidência
    /// 3 - Isenção
    /// 4 - Exportação
    /// 5 - Imunidade
    /// 6 - Exigibilidade Suspensa por Decisão Judicial
    /// 7 - Exigibilidade Suspensa por Processo Administrativo
    @Default('1') String exigibilidade,

    /// Retenção na fonte (opcional)
    @Default(false) bool retido,
  }) = _ISS;

  factory ISS.fromJson(Map<String, dynamic> json) => _$ISSFromJson(json);
}
