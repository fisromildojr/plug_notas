import 'package:flutter_test/flutter_test.dart';
import 'package:plug_notas/src/features/nfe/domain/entities/item.dart';
import 'package:plug_notas/src/features/nfe/domain/entities/tributos.dart';

void main() {
  group('Item', () {
    const tributosTeste = Tributos(
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
    );

    test('deve criar item completo', () {
      const item = Item(
        codigo: 'PROD-001',
        descricao: 'Produto Teste',
        ncm: '12345678',
        cfop: '5102',
        valor: 100.0,
        quantidade: 2,
        valorUnitario: 50.0,
        unidadeComercial: 'UN',
        tributos: tributosTeste,
      );

      expect(item.codigo, equals('PROD-001'));
      expect(item.descricao, equals('Produto Teste'));
      expect(item.ncm, equals('12345678'));
      expect(item.cfop, equals('5102'));
      expect(item.valor, equals(100.0));
      expect(item.quantidade, equals(2));
      expect(item.valorUnitario, equals(50.0));
      expect(item.unidadeComercial, equals('UN'));
      expect(item.tributos, equals(tributosTeste));
      expect(item.cest, isNull);
      expect(item.informacoesAdicionais, isNull);
    });

    test('deve criar item com CEST e informações adicionais', () {
      const item = Item(
        codigo: 'PROD-001',
        descricao: 'Produto Teste',
        ncm: '12345678',
        cfop: '5102',
        valor: 100.0,
        quantidade: 1,
        valorUnitario: 100.0,
        unidadeComercial: 'UN',
        tributos: tributosTeste,
        cest: '0100100',
        informacoesAdicionais: 'Informações extras',
      );

      expect(item.cest, equals('0100100'));
      expect(item.informacoesAdicionais, equals('Informações extras'));
    });

    test('deve calcular valor total corretamente', () {
      const item = Item(
        codigo: 'PROD-001',
        descricao: 'Produto Teste',
        ncm: '12345678',
        cfop: '5102',
        valor: 150.0,
        quantidade: 3,
        valorUnitario: 50.0,
        unidadeComercial: 'UN',
        tributos: tributosTeste,
      );

      expect(item.valor, equals(150.0));
      expect(item.quantidade * item.valorUnitario, equals(150.0));
    });

    test('deve serializar para JSON corretamente', () {
      const item = Item(
        codigo: 'PROD-001',
        descricao: 'Produto Teste',
        ncm: '12345678',
        cfop: '5102',
        valor: 100.0,
        quantidade: 1,
        valorUnitario: 100.0,
        unidadeComercial: 'UN',
        tributos: tributosTeste,
      );

      final json = item.toJson();

      expect(json['codigo'], equals('PROD-001'));
      expect(json['descricao'], equals('Produto Teste'));
      expect(json['ncm'], equals('12345678'));
      expect(json['cfop'], equals('5102'));
      expect(json['valor'], equals(100.0));
      expect(json['tributos'], isNotNull);
    });

    test('deve deserializar de JSON corretamente', () {
      final json = {
        'codigo': 'PROD-001',
        'descricao': 'Produto Teste',
        'ncm': '12345678',
        'cfop': '5102',
        'valor': 100.0,
        'quantidade': 1,
        'valorUnitario': 100.0,
        'unidadeComercial': 'UN',
        'tributos': {
          'icms': {
            'cst': '00',
            'baseCalculo': 100.0,
            'aliquota': 18.0,
            'valor': 18.0,
            'origem': '0',
          },
          'pis': {
            'cst': '01',
            'baseCalculo': 100.0,
            'aliquota': 1.65,
            'valor': 1.65,
          },
          'cofins': {
            'cst': '01',
            'baseCalculo': 100.0,
            'aliquota': 7.6,
            'valor': 7.6,
          },
        },
        'cest': '0100100',
      };

      final item = Item.fromJson(json);

      expect(item.codigo, equals('PROD-001'));
      expect(item.valor, equals(100.0));
      expect(item.tributos.icms.cst, equals('00'));
      expect(item.cest, equals('0100100'));
    });

    test('deve ser imutável com copyWith', () {
      const item = Item(
        codigo: 'PROD-001',
        descricao: 'Produto Teste',
        ncm: '12345678',
        cfop: '5102',
        valor: 100.0,
        quantidade: 1,
        valorUnitario: 100.0,
        unidadeComercial: 'UN',
        tributos: tributosTeste,
      );

      final novoItem = item.copyWith(
        quantidade: 5,
        valor: 500.0,
      );

      expect(item.quantidade, equals(1));
      expect(item.valor, equals(100.0));
      expect(novoItem.quantidade, equals(5));
      expect(novoItem.valor, equals(500.0));
      expect(novoItem.codigo, equals('PROD-001'));
    });
  });
}
