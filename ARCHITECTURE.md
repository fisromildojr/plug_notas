# 🏗️ Arquitetura do Pacote Plug Notas

## 📂 Estrutura de Diretórios

```
plug_notas/
│
├── lib/
│   ├── plug_notas.dart                    # 📦 Export principal (API pública)
│   │
│   └── src/
│       ├── core/                             # 🔧 Funcionalidades centrais
│       │   ├── config/
│       │   │   ├── plug_notas_config.dart       # Singleton de configuração
│       │   │   └── plug_notas_environment.dart  # Enum de ambientes
│       │   │
│       │   ├── constants/
│       │   │   └── plug_notas_constants.dart    # Constantes globais
│       │   │
│       │   ├── di/
│       │   │   └── dependency_injection.dart # GetIt configuration
│       │   │
│       │   ├── error/
│       │   │   └── exceptions.dart           # Hierarquia de exceções
│       │   │
│       │   └── network/
│       │       └── plug_notas_interceptor.dart  # Interceptor Dio
│       │
│       ├── features/                         # 🎯 Features por domínio
│       │   │
│       │   ├── fiscal/                       # Feature principal
│       │   │   ├── domain/
│       │   │   │   └── repositories/
│       │   │   │       └── fiscal_repository.dart  # Interface
│       │   │   │
│       │   │   └── data/
│       │   │       ├── datasources/
│       │   │       │   └── plug_notas_remote_datasource.dart
│       │   │       │
│       │   │       └── repositories/
│       │   │           └── fiscal_repository_impl.dart
│       │   │
│       │   ├── nfe/                          # NF-e
│       │   │   └── domain/
│       │   │       └── entities/
│       │   │           ├── nfe.dart
│       │   │           ├── emitente.dart
│       │   │           ├── destinatario.dart
│       │   │           ├── endereco.dart
│       │   │           ├── item.dart
│       │   │           ├── tributos.dart
│       │   │           └── pagamento.dart
│       │   │
│       │   └── nfse/                         # NFS-e
│       │       └── domain/
│       │           └── entities/
│       │               ├── nfse.dart
│       │               ├── prestador.dart
│       │               ├── tomador.dart
│       │               └── servico.dart
│       │
│       └── plug_notas_base.dart           # 🎭 Fachada pública
│
├── example/
│   └── main.dart                             # 📝 Exemplo completo de uso
│
├── pubspec.yaml                              # 📦 Dependências do pacote
├── README.md                                 # 📖 Documentação principal
├── QUICKSTART.md                             # 🚀 Guia rápido
├── CONTRIBUTING.md                           # 🤝 Guia de contribuição
├── CHANGELOG.md                              # 📋 Histórico de versões
├── LICENSE                                   # ⚖️ Licença MIT
├── build.sh                                  # 🔨 Script de build
└── .gitignore                                # 🚫 Arquivos ignorados
```

## 🎯 Camadas da Clean Architecture

### 1. **Domain Layer** (Regras de Negócio)
- ✅ **Entidades**: Classes imutáveis com Freezed
- ✅ **Interfaces de Repositório**: Contratos abstratos
- ❌ **SEM dependências externas**: Apenas Dart puro + Freezed

**Localização**: `lib/src/features/*/domain/`

### 2. **Data Layer** (Implementação)
- ✅ **Models**: DTOs com serialização JSON
- ✅ **DataSources**: Comunicação com API (Dio)
- ✅ **Repository Implementation**: Implementa interfaces do Domain

**Localização**: `lib/src/features/*/data/`

### 3. **Presentation Layer** (Interface Pública)
- ✅ **Fachada**: API simplificada para o desenvolvedor
- ✅ **Exports**: Exposição controlada das entidades

**Localização**: `lib/plug_notas.dart` e `lib/src/plug_notas_base.dart`

### 4. **Core** (Infraestrutura)
- ✅ **Config**: Gerenciamento de configuração
- ✅ **DI**: Injeção de dependências
- ✅ **Network**: Interceptors HTTP
- ✅ **Errors**: Tratamento de exceções

**Localização**: `lib/src/core/`

## 🔄 Fluxo de Dados

```
┌─────────────────┐
│  PlugNotas   │ ◄─── Desenvolvedor interage aqui
│   (Fachada)     │
└────────┬────────┘
         │
         ▼
┌─────────────────────┐
│ FiscalRepository    │
│   (Interface)       │
└────────┬────────────┘
         │
         ▼
┌──────────────────────────┐
│ FiscalRepositoryImpl     │
│  (Implementação)         │
└────────┬─────────────────┘
         │
         ▼
┌───────────────────────────┐
│ PlugNotasRemoteDataSource │
│   (Dio HTTP Client)       │
└────────┬──────────────────┘
         │
         ▼
┌─────────────────┐
│  API PlugNotas  │
└─────────────────┘
```

## 🔐 Gerenciamento de Dependências

```dart
GetIt (Service Locator)
  │
  ├─► Dio (HTTP Client)
  │    └─► PlugNotasInterceptor
  │
  ├─► PlugNotasRemoteDataSource
  │    └─► Dio
  │
  └─► FiscalRepository
       └─► PlugNotasRemoteDataSource
```

## 📝 Entidades Principais

### NF-e (Nota Fiscal Eletrônica)
```
NFe
 ├─ Emitente
 ├─ Destinatario
 │   └─ Endereco
 ├─ Item[] (Lista)
 │   ├─ Tributos
 │   │   ├─ ICMS
 │   │   ├─ PIS
 │   │   └─ COFINS
 │   └─ ...outros campos
 └─ Pagamento[] (Lista)
```

### NFS-e (Nota Fiscal de Serviço Eletrônica)
```
NFSe
 ├─ Prestador
 ├─ Tomador
 │   └─ Endereco
 └─ Servico
     └─ ISS
```

## 🛠️ Stack Tecnológica

| Biblioteca            | Versão | Propósito                            |
| --------------------- | ------ | ------------------------------------ |
| **dio**               | ^5.4.0 | Cliente HTTP com interceptors        |
| **freezed**           | ^2.4.6 | Geração de código para imutabilidade |
| **json_serializable** | ^6.7.1 | Serialização JSON automática         |
| **get_it**            | ^7.6.4 | Service Locator (DI)                 |
| **uuid**              | ^4.2.2 | Geração de IDs únicos                |

## 🎨 Princípios Aplicados

### SOLID
- ✅ **S**ingle Responsibility: Cada classe tem um propósito único
- ✅ **O**pen/Closed: Aberto para extensão via interfaces
- ✅ **L**iskov Substitution: Interfaces substituíveis
- ✅ **I**nterface Segregation: Interfaces específicas
- ✅ **D**ependency Inversion: Dependências via abstrações

### Clean Architecture
- ✅ Separação clara de camadas
- ✅ Domain independente de frameworks
- ✅ Fluxo de dependências unidirecional
- ✅ Testabilidade por design

### Design Patterns
- ✅ **Singleton**: PlugNotasConfig
- ✅ **Factory**: Constructors com Freezed
- ✅ **Repository Pattern**: FiscalRepository
- ✅ **Facade Pattern**: PlugNotas
- ✅ **Service Locator**: GetIt/DI

## 🚀 Próximos Passos

1. **Instalar dependências**:
   ```bash
   flutter pub get
   ```

2. **Gerar código Freezed**:
   ```bash
   chmod +x build.sh
   ./build.sh
   ```

3. **Executar exemplo**:
   ```bash
   dart run example/main.dart
   ```

## 📚 Documentação Adicional

- [README.md](README.md) - Documentação completa
- [QUICKSTART.md](QUICKSTART.md) - Guia de início rápido
- [example/main.dart](example/main.dart) - Exemplo funcional
- [CONTRIBUTING.md](CONTRIBUTING.md) - Como contribuir

---

**Desenvolvido com ❤️ seguindo as melhores práticas de arquitetura de software**
