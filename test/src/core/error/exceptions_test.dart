import 'package:flutter_test/flutter_test.dart';
import 'package:plug_notas/src/core/error/exceptions.dart';

void main() {
  group('PlugNotasException', () {
    test('deve criar exceção com mensagem', () {
      const exception = ValidationException('Erro de validação');

      expect(exception.message, equals('Erro de validação'));
      expect(exception.details, isNull);
    });

    test('deve criar exceção com mensagem e detalhes', () {
      const details = {'campo': 'cpfCnpj', 'erro': 'inválido'};
      const exception = ValidationException('Erro de validação', details);

      expect(exception.message, equals('Erro de validação'));
      expect(exception.details, equals(details));
    });

    test('toString deve retornar mensagem correta sem detalhes', () {
      const exception = ValidationException('Teste');

      expect(exception.toString(), equals('PlugNotasException: Teste'));
    });

    test('toString deve retornar mensagem correta com detalhes', () {
      const exception = ValidationException('Teste', 'detalhes extras');

      expect(
        exception.toString(),
        equals('PlugNotasException: Teste\nDetalhes: detalhes extras'),
      );
    });
  });

  group('AuthenticationException', () {
    test('deve criar com mensagem padrão', () {
      const exception = AuthenticationException();

      expect(
        exception.message,
        equals('Falha na autenticação. Verifique sua API Key.'),
      );
    });

    test('deve criar com mensagem customizada', () {
      const exception = AuthenticationException('API Key expirada');

      expect(exception.message, equals('API Key expirada'));
    });
  });

  group('ValidationException', () {
    test('deve criar corretamente com mensagem e detalhes', () {
      const details = {'erro': 'CPF inválido'};
      const exception = ValidationException('Validação falhou', details);

      expect(exception.message, equals('Validação falhou'));
      expect(exception.details, equals(details));
    });
  });

  group('ServerException', () {
    test('deve criar com mensagem padrão', () {
      const exception = ServerException();

      expect(
        exception.message,
        equals('Erro no servidor PlugNotas. Tente novamente mais tarde.'),
      );
    });

    test('deve criar com mensagem customizada', () {
      const exception = ServerException('Servidor em manutenção');

      expect(exception.message, equals('Servidor em manutenção'));
    });
  });

  group('NetworkException', () {
    test('deve criar com mensagem padrão', () {
      const exception = NetworkException();

      expect(
        exception.message,
        equals('Erro de conexão. Verifique sua internet.'),
      );
    });

    test('deve criar com mensagem customizada', () {
      const exception = NetworkException('Timeout na conexão');

      expect(exception.message, equals('Timeout na conexão'));
    });
  });

  group('NotFoundException', () {
    test('deve criar com mensagem padrão', () {
      const exception = NotFoundException();

      expect(exception.message, equals('Recurso não encontrado.'));
    });

    test('deve criar com mensagem customizada', () {
      const exception = NotFoundException('Nota não encontrada');

      expect(exception.message, equals('Nota não encontrada'));
    });
  });

  group('UnknownException', () {
    test('deve criar com mensagem padrão', () {
      const exception = UnknownException();

      expect(exception.message, equals('Erro desconhecido.'));
    });

    test('deve criar com mensagem e detalhes', () {
      const exception = UnknownException('Erro inesperado', 'stack trace');

      expect(exception.message, equals('Erro inesperado'));
      expect(exception.details, equals('stack trace'));
    });
  });
}
