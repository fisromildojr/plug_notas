# Plug Notas

Pacote Flutter profissional para integração com a API PlugNotas, facilitando a emissão de NF-e, NFC-e e NFS-e com arquitetura limpa e type-safe.

## 🏗️ Arquitetura

Este pacote foi desenvolvido seguindo **Clean Architecture** e princípios **SOLID**, garantindo:

- ✅ Testabilidade
- ✅ Manutenibilidade
- ✅ Desacoplamento
- ✅ Type Safety (Null Safety + Freezed)

## 📦 Instalação

```yaml
dependencies:
  plug_notas: ^1.0.0
```

## 🚀 Uso Rápido

### 1. Inicialização

```dart
import 'package:plug_notas/plug_notas.dart';

void main() async {
  // Inicializar em ambiente sandbox
  await PlugNotas.initialize(
    apiKey: 'sua-api-key-aqui',
    env: PlugNotasEnvironment.sandbox,
  );
}
```

### 2. Cadastrar Certificado Digital

```dart
final plugNotas = PlugNotas();

await plugNotas.cadastrarCertificado(
  caminhoArquivo: '/caminho/para/certificado.pfx',
  senha: 'senha-do-certificado',
);
```

### 3. Emitir NF-e

```dart
final nfe = NFe(
  idIntegracao: 'pedido-12345',
  presencial: true,
  consumidorFinal: true,
  natureza: 'VENDA',
  emitente: Emitente(
    cpfCnpj: '12345678000199',
  ),
  destinatario: Destinatario(
    cpfCnpj: '98765432000100',
    razaoSocial: 'Empresa Destinatária LTDA',
    email: 'contato@empresa.com.br',
    endereco: Endereco(
      codigoCidade: 3550308, // Código IBGE de São Paulo
      descricaoCidade: 'São Paulo',
      estado: 'SP',
      logradouro: 'Rua Exemplo',
      numero: '123',
      bairro: 'Centro',
      cep: '01310100',
    ),
  ),
  itens: [
    Item(
      codigo: 'PROD-001',
      descricao: 'Produto de Exemplo',
      ncm: '84715010',
      cfop: '5102',
      valor: 100.00,
      quantidade: 2,
      valorUnitario: 50.00,
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
    Pagamento(
      meio: '01', // Dinheiro
      valor: 200.00,
    ),
  ],
);

try {
  final protocolo = await plugNotas.emitirNFe(nfe);
  print('NF-e emitida com sucesso! Protocolo: $protocolo');
} on ValidationException catch (e) {
  print('Erro de validação: ${e.message}');
} on AuthenticationException catch (e) {
  print('Erro de autenticação: ${e.message}');
} on PlugNotasException catch (e) {
  print('Erro geral: ${e.message}');
}
```

### 4. Emitir NFS-e

```dart
final nfse = NFSe(
  idIntegracao: 'servico-98765',
  prestador: Prestador(
    cpfCnpj: '12345678000199',
    razaoSocial: 'Empresa Prestadora LTDA',
  ),
  tomador: Tomador(
    cpfCnpj: '98765432000100',
    razaoSocial: 'Empresa Tomadora LTDA',
    email: 'tomador@empresa.com.br',
    endereco: Endereco(
      codigoCidade: 3550308,
      descricaoCidade: 'São Paulo',
      estado: 'SP',
      logradouro: 'Av. Paulista',
      numero: '1000',
      bairro: 'Bela Vista',
      cep: '01310100',
    ),
  ),
  servico: Servico(
    codigo: '01.07',
    discriminacao: 'Serviços de consultoria em TI',
    cnae: '6202300',
    valorServico: 1000.00,
    iss: ISS(
      aliquota: 5.00,
      valor: 50.00,
    ),
  ),
);

final protocolo = await plugNotas.emitirNFSe(nfse);
print('NFS-e emitida! Protocolo: $protocolo');
```

## 🔧 Ambientes Disponíveis

- `PlugNotasEnvironment.sandbox` → https://api.sandbox.plugnotas.com.br
- `PlugNotasEnvironment.production` → https://api.plugnotas.com.br

## 🛡️ Tratamento de Erros

O pacote fornece exceções tipadas:

- `AuthenticationException` → Problema com API Key (401)
- `ValidationException` → Dados inválidos (400)
- `ServerException` → Erro no servidor PlugNotas (500)
- `NetworkException` → Problema de conexão

## 📚 Recursos

- [Documentação Oficial PlugNotas](https://docs.plugnotas.com.br/)
- [Códigos IBGE de Municípios](https://www.ibge.gov.br/explica/codigos-dos-municipios.php)
- [Tabela NCM](https://www.nfe.fazenda.gov.br/portal/principal.aspx)

## 📄 Licença

MIT License
