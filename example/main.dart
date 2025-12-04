import 'dart:convert';
import 'dart:developer';

import 'package:plug_notas/plug_notas.dart';

/// Exemplo completo de uso do pacote Plug Notas
void main() async {
  // =========================================================================
  // 1. INICIALIZAÇÃO
  // =========================================================================
  log('🚀 Inicializando Plug Notas...');

  await PlugNotas.initialize(
    apiKey: 'sua-api-key-aqui', // Obtenha em https://plugnotas.com.br
    env: PlugNotasEnvironment.sandbox, // Use production em produção
  );

  log('✅ Inicializado com sucesso!\n');

  // =========================================================================
  // 2. CRIAR INSTÂNCIA DO PACOTE
  // =========================================================================
  final plugNotas = PlugNotas();

  // =========================================================================
  // 3. CADASTRAR CERTIFICADO DIGITAL (Opcional, se ainda não cadastrado)
  // =========================================================================
  try {
    log('📜 Cadastrando certificado digital...');

    await plugNotas.cadastrarCertificado(
      '/caminho/para/seu/certificado.pfx',
      'senha-do-certificado',
    );

    log('✅ Certificado cadastrado com sucesso!\n');
  } on ValidationException catch (e) {
    log('❌ Erro ao cadastrar certificado: ${e.message}\n');
  }

  // =========================================================================
  // 4. EMITIR NF-e
  // =========================================================================
  try {
    log('📄 Emitindo NF-e...');

    final nfe = NFe(
      idIntegracao: 'VENDA-${DateTime.now().millisecondsSinceEpoch}',
      presencial: true,
      consumidorFinal: true,
      natureza: 'VENDA',
      emitente: const Emitente(
        cpfCnpj: '12345678000199',
      ),
      destinatario: const Destinatario(
        cpfCnpj: '98765432000100',
        razaoSocial: 'Empresa Destinatária LTDA',
        email: 'contato@empresa.com.br',
        endereco: Endereco(
          codigoCidade: 3550308, // São Paulo - SP
          descricaoCidade: 'São Paulo',
          estado: 'SP',
          logradouro: 'Rua Exemplo',
          numero: '123',
          bairro: 'Centro',
          cep: '01310100',
        ),
      ),
      itens: const [
        Item(
          codigo: 'PROD-001',
          descricao: 'Notebook Dell Inspiron 15',
          ncm: '84713012',
          cfop: '5102',
          valor: 3500.00,
          quantidade: 1,
          valorUnitario: 3500.00,
          unidadeComercial: 'UN',
          tributos: Tributos(
            icms: ICMS(
              cst: '00',
              baseCalculo: 3500.00,
              aliquota: 18.00,
              valor: 630.00,
              origem: '0',
            ),
            pis: PIS(
              cst: '01',
              baseCalculo: 3500.00,
              aliquota: 1.65,
              valor: 57.75,
            ),
            cofins: COFINS(
              cst: '01',
              baseCalculo: 3500.00,
              aliquota: 7.60,
              valor: 266.00,
            ),
          ),
        ),
      ],
      pagamentos: const [
        Pagamento(
          meio: PlugNotasConstants.pagamentoPix, // PIX
          valor: 3500.00,
        ),
      ],
      informacoesComplementares: 'Nota emitida via Plug Notas',
    );

    final protocoloNFe = await plugNotas.emitirNFe(nfe);

    log('✅ NF-e emitida com sucesso!');
    log('📋 Protocolo: $protocoloNFe\n');
  } on ValidationException catch (e) {
    log('❌ Erro de validação: ${e.message}');
    if (e.details != null) {
      log('Detalhes: ${e.details}\n');
    }
  } on AuthenticationException catch (e) {
    log('❌ Erro de autenticação: ${e.message}\n');
  } on NetworkException catch (e) {
    log('❌ Erro de rede: ${e.message}\n');
  } on PlugNotasException catch (e) {
    log('❌ Erro: ${e.message}\n');
  }

  // =========================================================================
  // 5. EMITIR NFS-e
  // =========================================================================
  try {
    log('📄 Emitindo NFS-e...');

    final nfse = NFSe(
      idIntegracao: 'SERVICO-${DateTime.now().millisecondsSinceEpoch}',
      prestador: const Prestador(
        cpfCnpj: '12345678000199',
        razaoSocial: 'Empresa Prestadora de Serviços LTDA',
        inscricaoMunicipal: '123456',
        regimeTributario: '6', // ME EPP - Simples Nacional
      ),
      tomador: const Tomador(
        cpfCnpj: '98765432000100',
        razaoSocial: 'Empresa Tomadora LTDA',
        email: 'tomador@empresa.com.br',
        endereco: Endereco(
          codigoCidade: 3550308, // São Paulo - SP
          descricaoCidade: 'São Paulo',
          estado: 'SP',
          logradouro: 'Av. Paulista',
          numero: '1000',
          bairro: 'Bela Vista',
          cep: '01310100',
        ),
        telefone: '11987654321',
      ),
      servico: const Servico(
        codigo: '01.07', // Desenvolvimento de programas de computador
        discriminacao: '''
Desenvolvimento de sistema web personalizado:
- Análise de requisitos
- Desenvolvimento frontend e backend
- Implementação de API REST
- Testes automatizados
- Deploy em produção
        ''',
        cnae: '6201501',
        valorServico: 15000.00,
        iss: ISS(
          aliquota: 5.00,
          valor: 750.00,
          exigibilidade: '1',
          retido: false,
        ),
        aliquotaPis: 0.65,
        aliquotaCofins: 3.00,
      ),
      informacoesComplementares: 'Projeto desenvolvido em 3 meses',
    );

    final protocoloNFSe = await plugNotas.emitirNFSe(nfse);

    log('✅ NFS-e emitida com sucesso!');
    log('📋 Protocolo: $protocoloNFSe\n');
  } on ValidationException catch (e) {
    log('❌ Erro de validação: ${e.message}');
    if (e.details != null) {
      log('Detalhes: ${e.details}\n');
    }
  } on PlugNotasException catch (e) {
    log('❌ Erro: ${e.message}\n');
  }

  // =========================================================================
  // 6. CONSULTAR NOTA EMITIDA
  // =========================================================================
  try {
    log('🔍 Consultando status da nota...');

    final statusNota = await plugNotas.consultarNota(
      'id-da-nota-aqui',
      'nfe', // ou 'nfse'
    );

    log('✅ Status da nota:');
    log(jsonEncode(statusNota));
  } on NotFoundException catch (e) {
    log('❌ Nota não encontrada: ${e.message}\n');
  } on PlugNotasException catch (e) {
    log('❌ Erro ao consultar: ${e.message}\n');
  }

  log('\n🎉 Exemplo finalizado!');
}
