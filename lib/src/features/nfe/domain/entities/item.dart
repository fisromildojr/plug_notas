import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plug_notas/src/features/nfe/domain/entities/tributos.dart';

part 'item.freezed.dart';
part 'item.g.dart';

/// Entidade representando um Item da NF-e
@freezed
class Item with _$Item {
  const factory Item({
    /// Código interno do produto
    required String codigo,

    /// Descrição do produto/serviço
    required String descricao,

    /// NCM - Nomenclatura Comum do Mercosul (8 dígitos)
    required String ncm,

    /// CFOP - Código Fiscal de Operações e Prestações (4 dígitos)
    required String cfop,

    /// Valor total do item (quantidade * valorUnitario)
    required double valor,

    /// Quantidade comercial
    required double quantidade,

    /// Valor unitário
    required double valorUnitario,

    /// Unidade comercial (UN, KG, MT, etc.)
    required String unidadeComercial,

    /// Tributos do item
    required Tributos tributos,

    /// Código de barras EAN/GTIN (opcional)
    String? codigoBarras,

    /// CEST - Código Especificador da Substituição Tributária (opcional)
    String? cest,

    /// Informações adicionais do item (opcional)
    String? informacoesAdicionais,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}
