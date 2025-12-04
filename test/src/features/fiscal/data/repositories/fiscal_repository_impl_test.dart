import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plug_notas/src/features/fiscal/data/datasources/plug_notas_remote_datasource.dart';
import 'package:plug_notas/src/features/fiscal/data/repositories/fiscal_repository_impl.dart';
import 'package:plug_notas/src/features/nfe/domain/entities/destinatario.dart';
import 'package:plug_notas/src/features/nfe/domain/entities/emitente.dart';
import 'package:plug_notas/src/features/nfe/domain/entities/endereco.dart';
import 'package:plug_notas/src/features/nfe/domain/entities/item.dart';
import 'package:plug_notas/src/features/nfe/domain/entities/nfe.dart';
import 'package:plug_notas/src/features/nfe/domain/entities/pagamento.dart';
import 'package:plug_notas/src/features/nfe/domain/entities/tributos.dart';
import 'package:plug_notas/src/features/nfse/domain/entities/nfse.dart';
import 'package:plug_notas/src/features/nfse/domain/entities/prestador.dart';
import 'package:plug_notas/src/features/nfse/domain/entities/servico.dart';
import 'package:plug_notas/src/features/nfse/domain/entities/tomador.dart';

class MockPlugNotasRemoteDataSource extends Mock
    implements PlugNotasRemoteDataSource {}

void main() {
  late FiscalRepositoryImpl repository;
  late MockPlugNotasRemoteDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockPlugNotasRemoteDataSource();
    repository = FiscalRepositoryImpl(mockDataSource);
  });

  group('FiscalRepositoryImpl', () {
    group('emitirNFe', () {
      test('deve emitir NFe e retornar ID quando bem sucedido', () async {
        // Arrange
        const nfe = NFe(
          idIntegracao: 'test-123',
          presencial: true,
          consumidorFinal: true,
          natureza: 'VENDA',
          emitente: Emitente(cpfCnpj: '12345678000199'),
          destinatario: Destinatario(
            cpfCnpj: '98765432000100',
            razaoSocial: 'Cliente LTDA',
            email: 'cliente@email.com',
            endereco: Endereco(
              codigoCidade: 3550308,
              descricaoCidade: 'São Paulo',
              estado: 'SP',
              logradouro: 'Rua Teste',
              numero: '123',
              bairro: 'Centro',
              cep: '01310100',
            ),
          ),
          itens: [
            Item(
              codigo: 'PROD-001',
              descricao: 'Produto',
              ncm: '12345678',
              cfop: '5102',
              valor: 100.0,
              quantidade: 1,
              valorUnitario: 100.0,
              unidadeComercial: 'UN',
              tributos: Tributos(
                icms: ICMS(
                  cst: '00',
                  baseCalculo: 100.0,
                  aliquota: 18.0,
                  valor: 18.0,
                ),
                pis: PIS(
                  cst: '01',
                  baseCalculo: 100.0,
                  aliquota: 1.65,
                  valor: 1.65,
                ),
                cofins: COFINS(
                  cst: '01',
                  baseCalculo: 100.0,
                  aliquota: 7.6,
                  valor: 7.6,
                ),
              ),
            ),
          ],
          pagamentos: [
            Pagamento(meio: '01', valor: 100.0),
          ],
        );

        when(() => mockDataSource.emitirNFe(any())).thenAnswer(
          (_) async => {'id': 'nota-123'},
        );

        // Act
        final result = await repository.emitirNFe(nfe);

        // Assert
        expect(result, equals('nota-123'));
        verify(() => mockDataSource.emitirNFe(any())).called(1);
      });

      test('deve retornar idIntegracao quando id não estiver disponível',
          () async {
        // Arrange
        const nfe = NFe(
          idIntegracao: 'test-123',
          presencial: true,
          consumidorFinal: true,
          natureza: 'VENDA',
          emitente: Emitente(cpfCnpj: '12345678000199'),
          destinatario: Destinatario(
            cpfCnpj: '98765432000100',
            razaoSocial: 'Cliente LTDA',
            email: 'cliente@email.com',
            endereco: Endereco(
              codigoCidade: 3550308,
              descricaoCidade: 'São Paulo',
              estado: 'SP',
              logradouro: 'Rua Teste',
              numero: '123',
              bairro: 'Centro',
              cep: '01310100',
            ),
          ),
          itens: [
            Item(
              codigo: 'PROD-001',
              descricao: 'Produto',
              ncm: '12345678',
              cfop: '5102',
              valor: 100.0,
              quantidade: 1,
              valorUnitario: 100.0,
              unidadeComercial: 'UN',
              tributos: Tributos(
                icms: ICMS(
                  cst: '00',
                  baseCalculo: 100.0,
                  aliquota: 18.0,
                  valor: 18.0,
                ),
                pis: PIS(
                  cst: '01',
                  baseCalculo: 100.0,
                  aliquota: 1.65,
                  valor: 1.65,
                ),
                cofins: COFINS(
                  cst: '01',
                  baseCalculo: 100.0,
                  aliquota: 7.6,
                  valor: 7.6,
                ),
              ),
            ),
          ],
          pagamentos: [
            Pagamento(meio: '01', valor: 100.0),
          ],
        );

        when(() => mockDataSource.emitirNFe(any())).thenAnswer(
          (_) async => {'idIntegracao': 'test-123'},
        );

        // Act
        final result = await repository.emitirNFe(nfe);

        // Assert
        expect(result, equals('test-123'));
      });
    });

    group('emitirNFSe', () {
      test('deve emitir NFSe e retornar ID', () async {
        // Arrange
        const nfse = NFSe(
          idIntegracao: 'servico-123',
          prestador: Prestador(
            cpfCnpj: '12345678000199',
            razaoSocial: 'Prestador LTDA',
          ),
          tomador: Tomador(
            cpfCnpj: '98765432000100',
            razaoSocial: 'Tomador LTDA',
            email: 'tomador@email.com',
            endereco: Endereco(
              codigoCidade: 3550308,
              descricaoCidade: 'São Paulo',
              estado: 'SP',
              logradouro: 'Rua Teste',
              numero: '123',
              bairro: 'Centro',
              cep: '01310100',
            ),
          ),
          servico: Servico(
            codigo: '01.07',
            discriminacao: 'Desenvolvimento',
            cnae: '6201501',
            valorServico: 1000.0,
            iss: ISS(
              aliquota: 5.0,
              valor: 50.0,
            ),
          ),
        );

        when(() => mockDataSource.emitirNFSe(any())).thenAnswer(
          (_) async => {'id': 'nfse-456'},
        );

        // Act
        final result = await repository.emitirNFSe(nfse);

        // Assert
        expect(result, equals('nfse-456'));
        verify(() => mockDataSource.emitirNFSe(any())).called(1);
      });
    });

    group('cadastrarCertificado', () {
      test('deve cadastrar certificado com sucesso', () async {
        // Arrange
        const caminho = '/path/to/cert.pfx';
        const senha = 'senha123';

        when(() => mockDataSource.cadastrarCertificado(caminho, senha))
            .thenAnswer((_) async => {});

        // Act
        await repository.cadastrarCertificado(caminho, senha);

        // Assert
        verify(() => mockDataSource.cadastrarCertificado(caminho, senha))
            .called(1);
      });
    });

    group('consultarNota', () {
      test('deve consultar nota e retornar dados', () async {
        // Arrange
        const id = 'nota-123';
        const tipo = 'nfe';
        final responseData = {'id': id, 'status': 'autorizada'};

        when(() => mockDataSource.consultarNota(id, tipo))
            .thenAnswer((_) async => responseData);

        // Act
        final result = await repository.consultarNota(id, tipo);

        // Assert
        expect(result, equals(responseData));
        verify(() => mockDataSource.consultarNota(id, tipo)).called(1);
      });
    });
  });
}
