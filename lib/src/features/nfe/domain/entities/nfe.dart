import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plug_notas/src/features/nfe/domain/entities/destinatario.dart';
import 'package:plug_notas/src/features/nfe/domain/entities/emitente.dart';
import 'package:plug_notas/src/features/nfe/domain/entities/item.dart';
import 'package:plug_notas/src/features/nfe/domain/entities/pagamento.dart';

part 'nfe.freezed.dart';
part 'nfe.g.dart';

/// Entidade principal representando uma NF-e (Nota Fiscal Eletrônica)
@freezed
class NFe with _$NFe {
  const factory NFe({
    /// ID de integração único (gerado pelo sistema integrador)
    required String idIntegracao,

    /// Indica se a venda é presencial
    required bool presencial,

    /// Indica se o destinatário é consumidor final
    required bool consumidorFinal,

    /// Natureza da operação (ex: 'VENDA', 'DEVOLUÇÃO', etc.)
    required String natureza,

    /// Dados do emitente
    required Emitente emitente,

    /// Dados do destinatário
    required Destinatario destinatario,

    /// Lista de itens da nota
    required List<Item> itens,

    /// Formas de pagamento
    required List<Pagamento> pagamentos,

    /// Informações adicionais (opcional)
    String? informacoesAdicionaisFisco,

    /// Informações complementares (opcional)
    String? informacoesComplementares,

    /// Número da nota (opcional - quando não informado, será gerado automaticamente)
    int? numero,

    /// Série da nota (opcional - padrão: 1)
    @Default(1) int serie,
  }) = _NFe;

  factory NFe.fromJson(Map<String, dynamic> json) => _$NFeFromJson(json);
}
