import 'package:flutter_test/flutter_test.dart';
import 'package:plug_notas/src/features/nfe/domain/entities/pagamento.dart';

void main() {
  group('Pagamento', () {
    test('deve criar pagamento com valores mínimos', () {
      const pagamento = Pagamento(
        meio: '01',
        valor: 100.0,
      );

      expect(pagamento.meio, equals('01'));
      expect(pagamento.valor, equals(100.0));
      expect(pagamento.tipoIntegracao, equals('2')); // Valor padrão
      expect(pagamento.cnpjCredenciadora, isNull);
      expect(pagamento.bandeiraOperadora, isNull);
      expect(pagamento.numeroAutorizacao, isNull);
    });

    test('deve criar pagamento completo para cartão', () {
      const pagamento = Pagamento(
        meio: '03',
        valor: 100.0,
        tipoIntegracao: '1',
        cnpjCredenciadora: '12345678000199',
        bandeiraOperadora: '01',
        numeroAutorizacao: 'AUTH123456',
      );

      expect(pagamento.meio, equals('03'));
      expect(pagamento.tipoIntegracao, equals('1'));
      expect(pagamento.cnpjCredenciadora, equals('12345678000199'));
      expect(pagamento.bandeiraOperadora, equals('01'));
      expect(pagamento.numeroAutorizacao, equals('AUTH123456'));
    });

    test('deve serializar para JSON corretamente', () {
      const pagamento = Pagamento(
        meio: '17',
        valor: 100.0,
      );

      final json = pagamento.toJson();

      expect(json['meio'], equals('17'));
      expect(json['valor'], equals(100.0));
      expect(json['tipoIntegracao'], equals('2'));
    });

    test('deve deserializar de JSON corretamente', () {
      final json = {
        'meio': '03',
        'valor': 200.0,
        'tipoIntegracao': '1',
        'cnpjCredenciadora': '12345678000199',
        'bandeiraOperadora': '02',
        'numeroAutorizacao': 'AUTH999',
      };

      final pagamento = Pagamento.fromJson(json);

      expect(pagamento.meio, equals('03'));
      expect(pagamento.valor, equals(200.0));
      expect(pagamento.cnpjCredenciadora, equals('12345678000199'));
      expect(pagamento.bandeiraOperadora, equals('02'));
    });

    test('deve ser imutável', () {
      const pagamento = Pagamento(
        meio: '01',
        valor: 100.0,
      );

      final novoPagamento = pagamento.copyWith(valor: 200.0);

      expect(pagamento.valor, equals(100.0));
      expect(novoPagamento.valor, equals(200.0));
    });

    test('copyWith deve manter valores não alterados', () {
      const pagamento = Pagamento(
        meio: '03',
        valor: 100.0,
        tipoIntegracao: '1',
        cnpjCredenciadora: '12345678000199',
      );

      final novoPagamento = pagamento.copyWith(valor: 150.0);

      expect(novoPagamento.meio, equals('03'));
      expect(novoPagamento.valor, equals(150.0));
      expect(novoPagamento.tipoIntegracao, equals('1'));
      expect(novoPagamento.cnpjCredenciadora, equals('12345678000199'));
    });
  });
}
