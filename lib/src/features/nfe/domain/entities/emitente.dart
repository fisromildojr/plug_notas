import 'package:freezed_annotation/freezed_annotation.dart';

part 'emitente.freezed.dart';
part 'emitente.g.dart';

/// Entidade representando o Emitente da NF-e
@freezed
class Emitente with _$Emitente {
  const factory Emitente({
    /// CPF ou CNPJ do emitente (apenas números)
    required String cpfCnpj,
  }) = _Emitente;

  factory Emitente.fromJson(Map<String, dynamic> json) =>
      _$EmitenteFromJson(json);
}
