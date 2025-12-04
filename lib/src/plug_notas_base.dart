import 'package:plug_notas/src/core/config/plug_notas_config.dart';
import 'package:plug_notas/src/core/config/plug_notas_environment.dart';
import 'package:plug_notas/src/core/di/dependency_injection.dart';
import 'package:plug_notas/src/features/fiscal/domain/repositories/fiscal_repository.dart';
import 'package:plug_notas/src/features/nfe/domain/entities/nfe.dart';
import 'package:plug_notas/src/features/nfse/domain/entities/nfse.dart';

/// Classe principal (Fachada) do pacote Plug Notas
///
/// Esta é a interface pública para interagir com a API PlugNotas.
/// Fornece métodos simplificados para emissão de notas fiscais e
/// gerenciamento de certificados digitais.
///
/// Exemplo de uso:
/// ```dart
/// // 1. Inicializar o pacote
/// await PlugNotas.initialize(
///   apiKey: 'sua-api-key',
///   env: PlugNotasEnvironment.sandbox,
/// );
///
/// // 2. Criar uma instância
/// final plugNotas = PlugNotas();
///
/// // 3. Emitir uma NF-e
/// final protocolo = await plugNotas.emitirNFe(nfe);
/// ```
class PlugNotas {
  PlugNotas() {
    _ensureInitialized();
    _repository = DependencyInjection.get<FiscalRepository>();
  }

  late final FiscalRepository _repository;

  /// Inicializa o pacote com as configurações necessárias
  ///
  /// Este método DEVE ser chamado antes de usar qualquer funcionalidade
  /// do pacote. Geralmente é chamado no início da aplicação.
  ///
  /// [apiKey] - API Key fornecida pela PlugNotas
  /// [env] - Ambiente de execução (sandbox ou production)
  ///
  /// Throws [StateError] se já foi inicializado
  static Future<void> initialize({
    required String apiKey,
    required PlugNotasEnvironment env,
  }) async {
    final config = PlugNotasConfig();

    if (config.isInitialized) {
      throw StateError(
        'PlugNotas já foi inicializado. '
        'Não é permitido inicializar múltiplas vezes.',
      );
    }

    // Configura o singleton de config
    config.initialize(apiKey: apiKey, environment: env);

    // Inicializa injeção de dependências
    await DependencyInjection.initialize();
  }

  /// Verifica se o pacote foi inicializado
  void _ensureInitialized() {
    if (!PlugNotasConfig().isInitialized) {
      throw StateError(
        'PlugNotas não foi inicializado. '
        'Chame PlugNotas.initialize() primeiro.',
      );
    }
  }

  /// Emite uma Nota Fiscal Eletrônica (NF-e)
  ///
  /// [nfe] - Entidade NF-e completa com todos os dados necessários
  ///
  /// Retorna o ID/protocolo da nota emitida
  ///
  /// Throws:
  /// - [ValidationException] quando os dados são inválidos
  /// - [AuthenticationException] quando a API Key é inválida
  /// - [ServerException] quando há erro no servidor PlugNotas
  /// - [NetworkException] quando há problema de conexão
  Future<String> emitirNFe(NFe nfe) async {
    return _repository.emitirNFe(nfe);
  }

  /// Emite uma Nota Fiscal de Serviço Eletrônica (NFS-e)
  ///
  /// [nfse] - Entidade NFS-e completa com todos os dados necessários
  ///
  /// Retorna o ID/protocolo da nota emitida
  ///
  /// Throws:
  /// - [ValidationException] quando os dados são inválidos
  /// - [AuthenticationException] quando a API Key é inválida
  /// - [ServerException] quando há erro no servidor PlugNotas
  /// - [NetworkException] quando há problema de conexão
  Future<String> emitirNFSe(NFSe nfse) async {
    return _repository.emitirNFSe(nfse);
  }

  /// Cadastra um certificado digital A1 (.pfx) na PlugNotas
  ///
  /// [caminhoArquivo] - Caminho completo para o arquivo .pfx do certificado
  /// [senha] - Senha do certificado digital
  ///
  /// Throws:
  /// - [ValidationException] quando o certificado é inválido
  /// - [AuthenticationException] quando a API Key é inválida
  /// - [ServerException] quando há erro no servidor PlugNotas
  /// - [NetworkException] quando há problema de conexão
  Future<void> cadastrarCertificado(
    String caminhoArquivo,
    String senha,
  ) async {
    return _repository.cadastrarCertificado(caminhoArquivo, senha);
  }

  /// Consulta o status de uma nota fiscal emitida
  ///
  /// [id] - ID da nota a ser consultada
  /// [tipo] - Tipo da nota ('nfe' ou 'nfse')
  ///
  /// Retorna um Map com os dados da nota e seu status atual
  ///
  /// Throws:
  /// - [NotFoundException] quando a nota não é encontrada
  /// - [AuthenticationException] quando a API Key é inválida
  /// - [ServerException] quando há erro no servidor PlugNotas
  /// - [NetworkException] quando há problema de conexão
  Future<Map<String, dynamic>> consultarNota(String id, String tipo) async {
    return _repository.consultarNota(id, tipo);
  }

  /// Reseta as configurações do pacote (útil para testes)
  ///
  /// ⚠️ CUIDADO: Este método deve ser usado apenas em ambientes de teste.
  /// Não utilize em produção.
  static Future<void> reset() async {
    PlugNotasConfig().reset();
    await DependencyInjection.reset();
  }
}
