import 'package:flutter_test/flutter_test.dart';
import 'package:plug_notas/src/features/nfe/domain/entities/emitente.dart';

void main() {
  group('Emitente', () {
    test('deve criar emitente com CPF/CNPJ', () {
      const emitente = Emitente(cpfCnpj: '12345678000199');

      expect(emitente.cpfCnpj, equals('12345678000199'));
    });

    test('deve ser igual quando tem mesmo CPF/CNPJ', () {
      const emitente1 = Emitente(cpfCnpj: '12345678000199');
      const emitente2 = Emitente(cpfCnpj: '12345678000199');

      expect(emitente1, equals(emitente2));
    });

    test('deve ser diferente quando tem CPF/CNPJ diferente', () {
      const emitente1 = Emitente(cpfCnpj: '12345678000199');
      const emitente2 = Emitente(cpfCnpj: '98765432000100');

      expect(emitente1, isNot(equals(emitente2)));
    });

    test('deve serializar para JSON corretamente', () {
      const emitente = Emitente(cpfCnpj: '12345678000199');

      final json = emitente.toJson();

      expect(json, equals({'cpfCnpj': '12345678000199'}));
    });

    test('deve deserializar de JSON corretamente', () {
      final json = {'cpfCnpj': '12345678000199'};

      final emitente = Emitente.fromJson(json);

      expect(emitente.cpfCnpj, equals('12345678000199'));
    });

    test('deve ter hashCode consistente', () {
      const emitente1 = Emitente(cpfCnpj: '12345678000199');
      const emitente2 = Emitente(cpfCnpj: '12345678000199');

      expect(emitente1.hashCode, equals(emitente2.hashCode));
    });

    test('copyWith deve criar nova instância com valores alterados', () {
      const emitente = Emitente(cpfCnpj: '12345678000199');

      final novoEmitente = emitente.copyWith(cpfCnpj: '98765432000100');

      expect(novoEmitente.cpfCnpj, equals('98765432000100'));
      expect(emitente.cpfCnpj, equals('12345678000199')); // Original não muda
    });
  });
}
