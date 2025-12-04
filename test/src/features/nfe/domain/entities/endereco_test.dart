import 'package:flutter_test/flutter_test.dart';
import 'package:plug_notas/src/features/nfe/domain/entities/endereco.dart';

void main() {
  group('Endereco', () {
    test('deve criar endereço completo', () {
      const endereco = Endereco(
        codigoCidade: 3550308,
        descricaoCidade: 'São Paulo',
        estado: 'SP',
        logradouro: 'Rua Exemplo',
        numero: '123',
        bairro: 'Centro',
        cep: '01310100',
      );

      expect(endereco.codigoCidade, equals(3550308));
      expect(endereco.descricaoCidade, equals('São Paulo'));
      expect(endereco.estado, equals('SP'));
      expect(endereco.logradouro, equals('Rua Exemplo'));
      expect(endereco.numero, equals('123'));
      expect(endereco.bairro, equals('Centro'));
      expect(endereco.cep, equals('01310100'));
      expect(endereco.complemento, isNull);
    });

    test('deve criar endereço com complemento', () {
      const endereco = Endereco(
        codigoCidade: 3550308,
        descricaoCidade: 'São Paulo',
        estado: 'SP',
        logradouro: 'Rua Exemplo',
        numero: '123',
        bairro: 'Centro',
        cep: '01310100',
        complemento: 'Apto 45',
      );

      expect(endereco.complemento, equals('Apto 45'));
    });

    test('deve serializar para JSON corretamente', () {
      const endereco = Endereco(
        codigoCidade: 3550308,
        descricaoCidade: 'São Paulo',
        estado: 'SP',
        logradouro: 'Rua Exemplo',
        numero: '123',
        bairro: 'Centro',
        cep: '01310100',
      );

      final json = endereco.toJson();

      expect(json['codigoCidade'], equals(3550308));
      expect(json['descricaoCidade'], equals('São Paulo'));
      expect(json['estado'], equals('SP'));
      expect(json['logradouro'], equals('Rua Exemplo'));
      expect(json['numero'], equals('123'));
      expect(json['bairro'], equals('Centro'));
      expect(json['cep'], equals('01310100'));
    });

    test('deve deserializar de JSON corretamente', () {
      final json = {
        'codigoCidade': 3550308,
        'descricaoCidade': 'São Paulo',
        'estado': 'SP',
        'logradouro': 'Rua Exemplo',
        'numero': '123',
        'bairro': 'Centro',
        'cep': '01310100',
        'complemento': 'Sala 10',
      };

      final endereco = Endereco.fromJson(json);

      expect(endereco.codigoCidade, equals(3550308));
      expect(endereco.complemento, equals('Sala 10'));
    });

    test('deve ser imutável', () {
      const endereco = Endereco(
        codigoCidade: 3550308,
        descricaoCidade: 'São Paulo',
        estado: 'SP',
        logradouro: 'Rua Exemplo',
        numero: '123',
        bairro: 'Centro',
        cep: '01310100',
      );

      final novoEndereco = endereco.copyWith(numero: '456');

      expect(endereco.numero, equals('123'));
      expect(novoEndereco.numero, equals('456'));
    });
  });
}
