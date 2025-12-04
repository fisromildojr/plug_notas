# Changelog

Todas as mudanças notáveis neste projeto serão documentadas neste arquivo.

O formato é baseado em [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
e este projeto adere ao [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.1] - 2025-12-04

### Fixed

- 🔗 Corrigido link inseguro (http) no README.md para usar HTTPS
- 📦 Gerados arquivos `.freezed.dart` e `.g.dart` faltantes para métodos `toJson`
- 📦 Atualizadas dependências para versões mais recentes:
  - `freezed_annotation` ^2.4.1 → ^3.0.0
  - `get_it` ^7.6.4 → ^8.0.0
  - `json_annotation` ^4.8.1 → ^4.9.0
  - `freezed` ^2.4.6 → ^3.0.0

## [1.0.0] - 2025-12-03

### Added

- ✨ Implementação inicial do pacote Plug Notas
- 🏗️ Arquitetura Clean Architecture com separação de camadas
- 📦 Entidades para NF-e com suporte completo a:
  - Emitente e Destinatário
  - Itens com tributos (ICMS, PIS, COFINS)
  - Múltiplas formas de pagamento
  - Endereços com código IBGE
- 📦 Entidades para NFS-e com suporte a:
  - Prestador e Tomador
  - Serviços com ISS
  - Deduções e descontos
- 🔐 Sistema de autenticação via API Key (header x-api-key)
- 🌍 Suporte a múltiplos ambientes (sandbox e production)
- 📜 Cadastro de certificados digitais A1 (.pfx)
- 🔍 Consulta de status de notas emitidas
- ⚠️ Tratamento de erros tipado com exceções específicas:
  - `ValidationException` - Erros de validação (400)
  - `AuthenticationException` - Erros de autenticação (401)
  - `NotFoundException` - Recurso não encontrado (404)
  - `ServerException` - Erros do servidor (500)
  - `NetworkException` - Problemas de conexão
- 🛠️ Interceptor Dio para tratamento automático de erros
- 💉 Injeção de dependências com GetIt
- 🧊 Imutabilidade com Freezed
- 🔒 Null Safety completo
- 📝 Documentação completa em português
- 🧪 Exemplo de uso abrangente

### Technical

- Dio ^5.4.0 para requisições HTTP
- Freezed ^2.4.6 para imutabilidade
- JSON Serializable ^6.7.1 para serialização
- GetIt ^7.6.4 para injeção de dependências
- UUID ^4.2.2 para geração de IDs únicos

[1.0.0]: https://github.com/fisromildojr/plug_notas/releases/tag/v1.0.0
