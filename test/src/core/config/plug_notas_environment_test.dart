import 'package:flutter_test/flutter_test.dart';
import 'package:plug_notas/src/core/config/plug_notas_environment.dart';

void main() {
  group('PlugNotasEnvironment', () {
    test('deve ter URL correta para sandbox', () {
      expect(
        PlugNotasEnvironment.sandbox.baseUrl,
        equals('https://api.sandbox.plugnotas.com.br'),
      );
    });

    test('deve ter URL correta para production', () {
      expect(
        PlugNotasEnvironment.production.baseUrl,
        equals('https://api.plugnotas.com.br'),
      );
    });

    test('deve ter dois valores disponíveis', () {
      expect(PlugNotasEnvironment.values.length, equals(2));
    });

    test('deve ser comparável por igualdade', () {
      expect(
        PlugNotasEnvironment.sandbox,
        equals(PlugNotasEnvironment.sandbox),
      );
      expect(
        PlugNotasEnvironment.production,
        equals(PlugNotasEnvironment.production),
      );
      expect(
        PlugNotasEnvironment.sandbox,
        isNot(equals(PlugNotasEnvironment.production)),
      );
    });
  });
}
