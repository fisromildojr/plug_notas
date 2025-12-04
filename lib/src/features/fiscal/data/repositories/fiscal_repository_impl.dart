import 'package:plug_notas/src/features/fiscal/data/datasources/plug_notas_remote_datasource.dart';
import 'package:plug_notas/src/features/fiscal/domain/repositories/fiscal_repository.dart';
import 'package:plug_notas/src/features/nfe/domain/entities/nfe.dart';
import 'package:plug_notas/src/features/nfse/domain/entities/nfse.dart';

/// Implementação do repositório fiscal
class FiscalRepositoryImpl implements FiscalRepository {
  FiscalRepositoryImpl(this._remoteDataSource);

  final PlugNotasRemoteDataSource _remoteDataSource;

  @override
  Future<String> emitirNFe(NFe nfe) async {
    // Converte a entidade para JSON (Freezed gera o toJson automaticamente)
    final nfeJson = nfe.toJson();

    // Envia para a API
    final response = await _remoteDataSource.emitirNFe(nfeJson);

    // Extrai o ID/protocolo da resposta
    // A PlugNotas retorna o ID em diferentes formatos dependendo do status
    final id = response['id'] as String? ??
        response['idIntegracao'] as String? ??
        response['protocolo'] as String?;

    if (id == null) {
      throw Exception('Resposta da API não contém ID da nota emitida');
    }

    return id;
  }

  @override
  Future<String> emitirNFSe(NFSe nfse) async {
    final nfseJson = nfse.toJson();
    final response = await _remoteDataSource.emitirNFSe(nfseJson);

    final id = response['id'] as String? ??
        response['idIntegracao'] as String? ??
        response['protocolo'] as String?;

    if (id == null) {
      throw Exception('Resposta da API não contém ID da nota emitida');
    }

    return id;
  }

  @override
  Future<void> cadastrarCertificado(String caminhoArquivo, String senha) async {
    await _remoteDataSource.cadastrarCertificado(caminhoArquivo, senha);
  }

  @override
  Future<Map<String, dynamic>> consultarNota(String id, String tipo) async {
    return _remoteDataSource.consultarNota(id, tipo);
  }
}
