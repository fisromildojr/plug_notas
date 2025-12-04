import 'package:flutter_test/flutter_test.dart';
import 'package:plug_notas/src/core/config/plug_notas_config.dart';
import 'package:plug_notas/src/core/config/plug_notas_environment.dart';

void main() {
  group('PlugNotasConfig', () {
    late PlugNotasConfig config;

    setUp(() {
      config = PlugNotasConfig();
      config.reset(); // Garantir estado limpo
    });

    tearDown(() {
      config.reset();
    });

    test('deve ser um Singleton', () {
      final config1 = PlugNotasConfig();
      final config2 = PlugNotasConfig();

      expect(config1, same(config2));
    });

    test('deve lançar StateError quando não inicializado e acessar apiKey', () {
      expect(
        () => config.apiKey,
        throwsA(isA<StateError>()),
      );
    });

    test('deve lançar StateError quando não inicializado e acessar environment',
        () {
      expect(
        () => config.environment,
        throwsA(isA<StateError>()),
      );
    });

    test('deve inicializar corretamente com sandbox', () {
      config.initialize(
        apiKey: 'test-api-key',
        environment: PlugNotasEnvironment.sandbox,
      );

      expect(config.apiKey, equals('test-api-key'));
      expect(config.environment, equals(PlugNotasEnvironment.sandbox));
      expect(config.baseUrl, equals('https://api.sandbox.plugnotas.com.br'));
      expect(config.isInitialized, isTrue);
    });

    test('deve inicializar corretamente com production', () {
      config.initialize(
        apiKey: 'prod-api-key',
        environment: PlugNotasEnvironment.production,
      );

      expect(config.apiKey, equals('prod-api-key'));
      expect(config.environment, equals(PlugNotasEnvironment.production));
      expect(config.baseUrl, equals('https://api.plugnotas.com.br'));
      expect(config.isInitialized, isTrue);
    });

    test('deve retornar false para isInitialized quando não inicializado', () {
      expect(config.isInitialized, isFalse);
    });

    test('deve resetar configurações', () {
      config.initialize(
        apiKey: 'test-key',
        environment: PlugNotasEnvironment.sandbox,
      );

      expect(config.isInitialized, isTrue);

      config.reset();

      expect(config.isInitialized, isFalse);
      expect(() => config.apiKey, throwsA(isA<StateError>()));
    });
  });
}
