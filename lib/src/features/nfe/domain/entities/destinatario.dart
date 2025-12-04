import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plug_notas/src/features/nfe/domain/entities/endereco.dart';

part 'destinatario.freezed.dart';
part 'destinatario.g.dart';

/// Entidade representando o Destinatário da NF-e
@freezed
class Destinatario with _$Destinatario {
  const factory Destinatario({
    /// CPF ou CNPJ do destinatário (apenas números)
    required String cpfCnpj,

    /// Razão Social ou Nome Completo
    required String razaoSocial,

    /// Email para envio da NF-e
    required String email,

    /// Endereço completo do destinatário
    required Endereco endereco,

    /// Inscrição Estadual (opcional)
    String? inscricaoEstadual,

    /// Telefone (opcional, apenas números)
    String? telefone,
  }) = _Destinatario;

  factory Destinatario.fromJson(Map<String, dynamic> json) =>
      _$DestinatarioFromJson(json);
}
