import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plug_notas/src/core/constants/plug_notas_constants.dart';
import 'package:plug_notas/src/core/error/exceptions.dart';
import 'package:plug_notas/src/features/fiscal/data/datasources/plug_notas_remote_datasource.dart';

class MockDio extends Mock implements Dio {}

class FakeRequestOptions extends Fake implements RequestOptions {}

void main() {
  late PlugNotasRemoteDataSource dataSource;
  late MockDio mockDio;

  setUpAll(() {
    registerFallbackValue(FakeRequestOptions());
  });

  setUp(() {
    mockDio = MockDio();
    dataSource = PlugNotasRemoteDataSourceImpl(mockDio);
  });

  group('PlugNotasRemoteDataSource', () {
    group('emitirNFe', () {
      test('deve retornar dados quando requisição for bem sucedida', () async {
        // Arrange
        final nfeData = {'idIntegracao': 'test-123'};
        final responseData = {'id': 'nota-123', 'status': 'sucesso'};

        when(
          () => mockDio.post<Map<String, dynamic>>(
            PlugNotasConstants.nfeEndpoint,
            data: nfeData,
          ),
        ).thenAnswer(
          (_) async => Response(
            data: responseData,
            statusCode: 200,
            requestOptions:
                RequestOptions(path: PlugNotasConstants.nfeEndpoint),
          ),
        );

        // Act
        final result = await dataSource.emitirNFe(nfeData);

        // Assert
        expect(result, equals(responseData));
        verify(
          () => mockDio.post<Map<String, dynamic>>(
            PlugNotasConstants.nfeEndpoint,
            data: nfeData,
          ),
        ).called(1);
      });

      test('deve lançar ServerException quando resposta for nula', () async {
        // Arrange
        final nfeData = {'idIntegracao': 'test-123'};

        when(
          () => mockDio.post<Map<String, dynamic>>(
            PlugNotasConstants.nfeEndpoint,
            data: nfeData,
          ),
        ).thenAnswer(
          (_) async => Response(
            data: null,
            statusCode: 200,
            requestOptions:
                RequestOptions(path: PlugNotasConstants.nfeEndpoint),
          ),
        );

        // Act & Assert
        expect(
          () => dataSource.emitirNFe(nfeData),
          throwsA(isA<ServerException>()),
        );
      });

      test('deve propagar PlugNotasException do interceptor', () async {
        // Arrange
        final nfeData = {'idIntegracao': 'test-123'};
        const exception = ValidationException('Dados inválidos');

        when(
          () => mockDio.post<Map<String, dynamic>>(
            PlugNotasConstants.nfeEndpoint,
            data: nfeData,
          ),
        ).thenThrow(
          DioException(
            requestOptions:
                RequestOptions(path: PlugNotasConstants.nfeEndpoint),
            error: exception,
          ),
        );

        // Act & Assert
        expect(
          () => dataSource.emitirNFe(nfeData),
          throwsA(isA<ValidationException>()),
        );
      });
    });

    group('emitirNFSe', () {
      test('deve retornar dados quando requisição for bem sucedida', () async {
        // Arrange
        final nfseData = {'idIntegracao': 'servico-123'};
        final responseData = {'id': 'nfse-123', 'status': 'autorizada'};

        when(
          () => mockDio.post<Map<String, dynamic>>(
            PlugNotasConstants.nfseEndpoint,
            data: nfseData,
          ),
        ).thenAnswer(
          (_) async => Response(
            data: responseData,
            statusCode: 200,
            requestOptions:
                RequestOptions(path: PlugNotasConstants.nfseEndpoint),
          ),
        );

        // Act
        final result = await dataSource.emitirNFSe(nfseData);

        // Assert
        expect(result, equals(responseData));
      });
    });

    group('consultarNota', () {
      test('deve consultar NFe corretamente', () async {
        // Arrange
        const id = 'nota-123';
        const tipo = 'nfe';
        final responseData = {'id': id, 'status': 'autorizada'};

        when(
          () => mockDio.get<Map<String, dynamic>>(
            '${PlugNotasConstants.nfeEndpoint}/$id',
          ),
        ).thenAnswer(
          (_) async => Response(
            data: responseData,
            statusCode: 200,
            requestOptions:
                RequestOptions(path: '${PlugNotasConstants.nfeEndpoint}/$id'),
          ),
        );

        // Act
        final result = await dataSource.consultarNota(id, tipo);

        // Assert
        expect(result, equals(responseData));
        verify(
          () => mockDio.get<Map<String, dynamic>>(
            '${PlugNotasConstants.nfeEndpoint}/$id',
          ),
        ).called(1);
      });

      test('deve consultar NFSe corretamente', () async {
        // Arrange
        const id = 'nfse-123';
        const tipo = 'nfse';
        final responseData = {'id': id, 'status': 'autorizada'};

        when(
          () => mockDio.get<Map<String, dynamic>>(
            '${PlugNotasConstants.nfseEndpoint}/$id',
          ),
        ).thenAnswer(
          (_) async => Response(
            data: responseData,
            statusCode: 200,
            requestOptions:
                RequestOptions(path: '${PlugNotasConstants.nfseEndpoint}/$id'),
          ),
        );

        // Act
        final result = await dataSource.consultarNota(id, tipo);

        // Assert
        expect(result, equals(responseData));
      });
    });
  });
}
