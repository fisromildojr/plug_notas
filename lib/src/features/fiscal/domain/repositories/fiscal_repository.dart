import 'package:plug_notas/src/features/nfe/domain/entities/nfe.dart';
import 'package:plug_notas/src/features/nfse/domain/entities/nfse.dart';

/// Interface do repositório fiscal
abstract class FiscalRepository {
  /// Emite uma NF-e e retorna o ID/protocolo
  Future<String> emitirNFe(NFe nfe);

  /// Emite uma NFS-e e retorna o ID/protocolo
  Future<String> emitirNFSe(NFSe nfse);

  /// Cadastra um certificado digital
  Future<void> cadastrarCertificado(String caminhoArquivo, String senha);

  /// Consulta o status de uma nota
  Future<Map<String, dynamic>> consultarNota(String id, String tipo);
}
