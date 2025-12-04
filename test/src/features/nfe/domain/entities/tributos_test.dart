import 'package:flutter_test/flutter_test.dart';
import 'package:plug_notas/src/features/nfe/domain/entities/tributos.dart';

void main() {
  group('ICMS', () {
    test('deve criar ICMS com valores corretos', () {
      const icms = ICMS(
        cst: '00',
        baseCalculo: 100.0,
        aliquota: 18.0,
        valor: 18.0,
      );

      expect(icms.cst, equals('00'));
      expect(icms.baseCalculo, equals(100.0));
      expect(icms.aliquota, equals(18.0));
      expect(icms.valor, equals(18.0));
      expect(icms.origem, equals('0')); // Valor padrão
    });

    test('deve aceitar origem customizada', () {
      const icms = ICMS(
        cst: '00',
        baseCalculo: 100.0,
        aliquota: 18.0,
        valor: 18.0,
        origem: '1',
      );

      expect(icms.origem, equals('1'));
    });

    test('deve serializar para JSON', () {
      const icms = ICMS(
        cst: '00',
        baseCalculo: 100.0,
        aliquota: 18.0,
        valor: 18.0,
      );

      final json = icms.toJson();

      expect(json['cst'], equals('00'));
      expect(json['baseCalculo'], equals(100.0));
      expect(json['origem'], equals('0'));
    });
  });

  group('PIS', () {
    test('deve criar PIS com valores corretos', () {
      const pis = PIS(
        cst: '01',
        baseCalculo: 100.0,
        aliquota: 1.65,
        valor: 1.65,
      );

      expect(pis.cst, equals('01'));
      expect(pis.baseCalculo, equals(100.0));
      expect(pis.aliquota, equals(1.65));
      expect(pis.valor, equals(1.65));
    });

    test('deve serializar para JSON', () {
      const pis = PIS(
        cst: '01',
        baseCalculo: 100.0,
        aliquota: 1.65,
        valor: 1.65,
      );

      final json = pis.toJson();

      expect(json['cst'], equals('01'));
      expect(json['baseCalculo'], equals(100.0));
    });
  });

  group('COFINS', () {
    test('deve criar COFINS com valores corretos', () {
      const cofins = COFINS(
        cst: '01',
        baseCalculo: 100.0,
        aliquota: 7.6,
        valor: 7.6,
      );

      expect(cofins.cst, equals('01'));
      expect(cofins.baseCalculo, equals(100.0));
      expect(cofins.aliquota, equals(7.6));
      expect(cofins.valor, equals(7.6));
    });

    test('deve serializar para JSON', () {
      const cofins = COFINS(
        cst: '01',
        baseCalculo: 100.0,
        aliquota: 7.6,
        valor: 7.6,
      );

      final json = cofins.toJson();

      expect(json['cst'], equals('01'));
      expect(json['valor'], equals(7.6));
    });
  });

  group('Tributos', () {
    test('deve criar Tributos completo', () {
      const tributos = Tributos(
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

      expect(tributos.icms.cst, equals('00'));
      expect(tributos.pis.cst, equals('01'));
      expect(tributos.cofins.cst, equals('01'));
    });

    test('deve serializar para JSON corretamente', () {
      const tributos = Tributos(
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

      final json = tributos.toJson();

      expect(json, isA<Map>());
      expect(json['icms'], isNotNull);
      expect(json['pis'], isNotNull);
      expect(json['cofins'], isNotNull);
    });

    test('deve deserializar de JSON corretamente', () {
      final json = {
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
      };

      final tributos = Tributos.fromJson(json);

      expect(tributos.icms.cst, equals('00'));
      expect(tributos.pis.aliquota, equals(1.65));
      expect(tributos.cofins.valor, equals(7.6));
    });
  });
}
