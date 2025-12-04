import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:plug_notas/src/core/config/plug_notas_config.dart';
import 'package:plug_notas/src/core/config/plug_notas_environment.dart';
import 'package:plug_notas/src/plug_notas_base.dart';

void main() {
  group('PlugNotas', () {
    setUp(() {
      PlugNotasConfig().reset();
      GetIt.instance.reset();
    });

    tearDown(() {
      PlugNotasConfig().reset();
      GetIt.instance.reset();
    });

    test('deve lançar StateError quando não inicializado', () {
      expect(
        () => PlugNotas(),
        throwsA(isA<StateError>()),
      );
    });

    test('initialize deve configurar corretamente', () async {
      await PlugNotas.initialize(
        apiKey: 'test-key',
        env: PlugNotasEnvironment.sandbox,
      );

      final config = PlugNotasConfig();
      expect(config.isInitialized, isTrue);
      expect(config.apiKey, equals('test-key'));
      expect(config.environment, equals(PlugNotasEnvironment.sandbox));
    });

    test('initialize deve lançar erro quando já inicializado', () async {
      await PlugNotas.initialize(
        apiKey: 'test-key',
        env: PlugNotasEnvironment.sandbox,
      );

      expect(
        () => PlugNotas.initialize(
          apiKey: 'another-key',
          env: PlugNotasEnvironment.production,
        ),
        throwsA(isA<StateError>()),
      );
    });

    test('reset deve limpar configurações', () async {
      await PlugNotas.initialize(
        apiKey: 'test-key',
        env: PlugNotasEnvironment.sandbox,
      );

      expect(PlugNotasConfig().isInitialized, isTrue);

      await PlugNotas.reset();

      expect(PlugNotasConfig().isInitialized, isFalse);
    });
  });
}
