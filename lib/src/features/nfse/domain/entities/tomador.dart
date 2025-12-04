import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plug_notas/src/features/nfe/domain/entities/endereco.dart';

part 'tomador.freezed.dart';
part 'tomador.g.dart';

/// Entidade representando o Tomador de Serviços (NFS-e)
@freezed
class Tomador with _$Tomador {
  const factory Tomador({
    /// CPF ou CNPJ do tomador (apenas números)
    required String cpfCnpj,

    /// Razão Social ou Nome Completo
    required String razaoSocial,

    /// Email para envio da NFS-e
    required String email,

    /// Endereço completo do tomador
    required Endereco endereco,

    /// Telefone (opcional, apenas números)
    String? telefone,
  }) = _Tomador;

  factory Tomador.fromJson(Map<String, dynamic> json) =>
      _$TomadorFromJson(json);
}
