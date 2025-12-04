import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:plug_notas/src/core/config/plug_notas_config.dart';
import 'package:plug_notas/src/core/constants/plug_notas_constants.dart';
import 'package:plug_notas/src/core/network/plug_notas_interceptor.dart';
import 'package:plug_notas/src/features/fiscal/data/datasources/plug_notas_remote_datasource.dart';
import 'package:plug_notas/src/features/fiscal/data/repositories/fiscal_repository_impl.dart';
import 'package:plug_notas/src/features/fiscal/domain/repositories/fiscal_repository.dart';

/// Gerenciador de injeção de dependências do pacote
class DependencyInjection {
  DependencyInjection._();

  static final GetIt _getIt = GetIt.instance;

  /// Inicializa todas as dependências
  static Future<void> initialize() async {
    final config = PlugNotasConfig();

    // Registra o Dio com configurações
    _getIt.registerLazySingleton<Dio>(
      () => Dio(
        BaseOptions(
          baseUrl: config.baseUrl,
          connectTimeout: const Duration(
            milliseconds: PlugNotasConstants.connectTimeout,
          ),
          receiveTimeout: const Duration(
            milliseconds: PlugNotasConstants.receiveTimeout,
          ),
          sendTimeout: const Duration(
            milliseconds: PlugNotasConstants.sendTimeout,
          ),
        ),
      )..interceptors.add(PlugNotasInterceptor(config)),
    );

    // Registra o DataSource
    _getIt.registerLazySingleton<PlugNotasRemoteDataSource>(
      () => PlugNotasRemoteDataSourceImpl(_getIt<Dio>()),
    );

    // Registra o Repository
    _getIt.registerLazySingleton<FiscalRepository>(
      () => FiscalRepositoryImpl(_getIt<PlugNotasRemoteDataSource>()),
    );
  }

  /// Obtém uma instância registrada
  static T get<T extends Object>() => _getIt<T>();

  /// Reseta todas as dependências (útil para testes)
  static Future<void> reset() async {
    await _getIt.reset();
  }
}
