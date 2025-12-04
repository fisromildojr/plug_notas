# Guia de Início Rápido - Plug Notas

## 📋 Pré-requisitos

- Flutter SDK ≥ 3.0.0
- Dart SDK ≥ 3.0.0
- API Key da PlugNotas ([obtenha aqui](https://plugnotas.com.br))
- Certificado Digital A1 (.pfx) para emissão de notas

## 🚀 Instalação

### 1. Adicione a dependência

```yaml
# pubspec.yaml
dependencies:
  plug_notas: ^1.0.0
```

### 2. Instale as dependências

```bash
flutter pub get
```

### 3. Gere os arquivos Freezed (se estiver desenvolvendo o pacote)

```bash
# Linux/Mac
chmod +x build.sh
./build.sh

# Windows
flutter pub run build_runner build --delete-conflicting-outputs
```

## 📝 Uso Básico

### Inicialização

```dart
import 'package:plug_notas/plug_notas.dart';

void main() async {
  // Inicializar no início da aplicação
  await PlugNotas.initialize(
    apiKey: 'SUA_API_KEY_AQUI',
    env: PlugNotasEnvironment.sandbox, // ou .production
  );

  // Criar instância
  final plug_notas = PlugNotas();
}
```

### Emitir NF-e

```dart
final nfe = NFe(
  idIntegracao: 'VENDA-123',
  presencial: true,
  consumidorFinal: true,
  natureza: 'VENDA',
  emitente: const Emitente(cpfCnpj: '12345678000199'),
  destinatario: const Destinatario(
    cpfCnpj: '98765432000100',
    razaoSocial: 'Cliente LTDA',
    email: 'cliente@email.com',
    endereco: Endereco(
      codigoCidade: 3550308,
      descricaoCidade: 'São Paulo',
      estado: 'SP',
      logradouro: 'Rua Exemplo',
      numero: '123',
      bairro: 'Centro',
      cep: '01310100',
    ),
  ),
  itens: [
    const Item(
      codigo: 'PROD-001',
      descricao: 'Produto Exemplo',
      ncm: '84715010',
      cfop: '5102',
      valor: 100.00,
      quantidade: 1,
      valorUnitario: 100.00,
      unidadeComercial: 'UN',
      tributos: Tributos(
        icms: ICMS(
          cst: '00',
          baseCalculo: 100.00,
          aliquota: 18.00,
          valor: 18.00,
        ),
        pis: PIS(
          cst: '01',
          baseCalculo: 100.00,
          aliquota: 1.65,
          valor: 1.65,
        ),
        cofins: COFINS(
          cst: '01',
          baseCalculo: 100.00,
          aliquota: 7.60,
          valor: 7.60,
        ),
      ),
    ),
  ],
  pagamentos: [
    const Pagamento(
      meio: PlugNotasConstants.pagamentoPix,
      valor: 100.00,
    ),
  ],
);

try {
  final protocolo = await plug_notas.emitirNFe(nfe);
  print('NF-e emitida: $protocolo');
} on ValidationException catch (e) {
  print('Erro de validação: ${e.message}');
  print('Detalhes: ${e.details}');
} on AuthenticationException catch (e) {
  print('Erro de autenticação: ${e.message}');
}
```

## 🔐 Cadastrar Certificado

```dart
await plug_notas.cadastrarCertificado(
  '/caminho/para/certificado.pfx',
  'senha-do-certificado',
);
```

## 📊 Códigos Úteis

### Meios de Pagamento

```dart
PlugNotasConstants.pagamentoDinheiro        // '01'
PlugNotasConstants.pagamentoCartaoCredito   // '03'
PlugNotasConstants.pagamentoCartaoDebito    // '04'
PlugNotasConstants.pagamentoPix             // '17'
PlugNotasConstants.pagamentoBoleto          // '15'
```

### Consultar Código IBGE

Consulte códigos de municípios em:
https://www.ibge.gov.br/explica/codigos-dos-municipios.php

### Consultar NCM

Consulte códigos NCM em:
http://www.nfe.fazenda.gov.br/portal/principal.aspx

## 🐛 Tratamento de Erros

```dart
try {
  await plug_notas.emitirNFe(nfe);
} on ValidationException catch (e) {
  // Dados inválidos (400)
  print('Validação: ${e.message}');
} on AuthenticationException catch (e) {
  // API Key inválida (401)
  print('Autenticação: ${e.message}');
} on NotFoundException catch (e) {
  // Recurso não encontrado (404)
  print('Não encontrado: ${e.message}');
} on ServerException catch (e) {
  // Erro no servidor (500)
  print('Servidor: ${e.message}');
} on NetworkException catch (e) {
  // Problema de conexão
  print('Rede: ${e.message}');
} on PlugNotasException catch (e) {
  // Outros erros
  print('Erro: ${e.message}');
}
```

## 📚 Recursos

- [Exemplo Completo](example/main.dart)
- [Documentação PlugNotas](https://docs.plugnotas.com.br/)
- [API Reference](#)

## ⚙️ Variáveis de Ambiente

Para projetos em produção, use variáveis de ambiente:

```dart
await PlugNotas.initialize(
  apiKey: const String.fromEnvironment('PLUGNOTAS_API_KEY'),
  env: PlugNotasEnvironment.production,
);
```

Execute com:
```bash
flutter run --dart-define=PLUGNOTAS_API_KEY=sua-chave-aqui
```
