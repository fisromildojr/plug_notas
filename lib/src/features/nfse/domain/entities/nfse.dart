import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plug_notas/src/features/nfse/domain/entities/prestador.dart';
import 'package:plug_notas/src/features/nfse/domain/entities/servico.dart';
import 'package:plug_notas/src/features/nfse/domain/entities/tomador.dart';

part 'nfse.freezed.dart';
part 'nfse.g.dart';

/// Entidade principal representando uma NFS-e (Nota Fiscal de Serviço Eletrônica)
@freezed
class NFSe with _$NFSe {
  const factory NFSe({
    /// ID de integração único (gerado pelo sistema integrador)
    required String idIntegracao,

    /// Dados do prestador de serviços
    required Prestador prestador,

    /// Dados do tomador de serviços
    required Tomador tomador,

    /// Dados do serviço prestado
    required Servico servico,

    /// Informações adicionais (opcional)
    String? informacoesComplementares,
  }) = _NFSe;

  factory NFSe.fromJson(Map<String, dynamic> json) => _$NFSeFromJson(json);
}
