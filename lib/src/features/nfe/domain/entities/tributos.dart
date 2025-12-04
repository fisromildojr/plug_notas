import 'package:freezed_annotation/freezed_annotation.dart';

part 'tributos.freezed.dart';
part 'tributos.g.dart';

/// Tributos de um item da NF-e (ICMS, PIS, COFINS)
@freezed
class Tributos with _$Tributos {
  const factory Tributos({
    required ICMS icms,
    required PIS pis,
    required COFINS cofins,
  }) = _Tributos;

  factory Tributos.fromJson(Map<String, dynamic> json) =>
      _$TributosFromJson(json);
}

/// ICMS - Imposto sobre Circulação de Mercadorias e Serviços
@freezed
class ICMS with _$ICMS {
  const factory ICMS({
    /// Código de Situação Tributária (CST)
    /// Ex: '00', '10', '20', '30', '40', '41', '50', '51', '60', '70', '90'
    required String cst,

    /// Base de cálculo do ICMS
    required double baseCalculo,

    /// Alíquota do ICMS (percentual)
    required double aliquota,

    /// Valor do ICMS
    required double valor,

    /// Origem da mercadoria (0 a 8)
    @Default('0') String origem,
  }) = _ICMS;

  factory ICMS.fromJson(Map<String, dynamic> json) => _$ICMSFromJson(json);
}

/// PIS - Programa de Integração Social
@freezed
class PIS with _$PIS {
  const factory PIS({
    /// Código de Situação Tributária
    /// Ex: '01', '02', '03', '04', '05', '06', '07', '08', '09', '49', '50', '51', '52', '53', '54', '55', '56', '60', '61', '62', '63', '64', '65', '66', '67', '70', '71', '72', '73', '74', '75', '98', '99'
    required String cst,

    /// Base de cálculo do PIS
    required double baseCalculo,

    /// Alíquota do PIS (percentual)
    required double aliquota,

    /// Valor do PIS
    required double valor,
  }) = _PIS;

  factory PIS.fromJson(Map<String, dynamic> json) => _$PISFromJson(json);
}

/// COFINS - Contribuição para Financiamento da Seguridade Social
@freezed
class COFINS with _$COFINS {
  const factory COFINS({
    /// Código de Situação Tributária
    required String cst,

    /// Base de cálculo do COFINS
    required double baseCalculo,

    /// Alíquota do COFINS (percentual)
    required double aliquota,

    /// Valor do COFINS
    required double valor,
  }) = _COFINS;

  factory COFINS.fromJson(Map<String, dynamic> json) => _$COFINSFromJson(json);
}
