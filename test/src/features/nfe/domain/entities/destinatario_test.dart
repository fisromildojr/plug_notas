import 'package:flutter_test/flutter_test.dart';
import 'package:plug_notas/src/features/nfe/domain/entities/destinatario.dart';
import 'package:plug_notas/src/features/nfe/domain/entities/endereco.dart';

void main() {
  group('Destinatario', () {
    const enderecoTeste = Endereco(
      codigoCidade: 3550308,
      descricaoCidade: 'São Paulo',
      estado: 'SP',
      logradouro: 'Rua Teste',
      numero: '123',
      bairro: 'Centro',
      cep: '01310100',
    );

    test('deve criar destinatário completo', () {
      const destinatario = Destinatario(
        cpfCnpj: '98765432000100',
        razaoSocial: 'Cliente LTDA',
        email: 'cliente@email.com',
        endereco: enderecoTeste,
      );

      expect(destinatario.cpfCnpj, equals('98765432000100'));
      expect(destinatario.razaoSocial, equals('Cliente LTDA'));
      expect(destinatario.email, equals('cliente@email.com'));
      expect(destinatario.endereco, equals(enderecoTeste));
      expect(destinatario.inscricaoEstadual, isNull);
      expect(destinatario.telefone, isNull);
    });

    test('deve criar destinatário com inscrição estadual', () {
      const destinatario = Destinatario(
        cpfCnpj: '98765432000100',
        razaoSocial: 'Cliente LTDA',
        email: 'cliente@email.com',
        endereco: enderecoTeste,
        inscricaoEstadual: '123456789',
      );

      expect(destinatario.inscricaoEstadual, equals('123456789'));
    });

    test('deve criar destinatário com telefone', () {
      const destinatario = Destinatario(
        cpfCnpj: '98765432000100',
        razaoSocial: 'Cliente LTDA',
        email: 'cliente@email.com',
        endereco: enderecoTeste,
        telefone: '11987654321',
      );

      expect(destinatario.telefone, equals('11987654321'));
    });

    test('deve serializar para JSON corretamente', () {
      const destinatario = Destinatario(
        cpfCnpj: '98765432000100',
        razaoSocial: 'Cliente LTDA',
        email: 'cliente@email.com',
        endereco: enderecoTeste,
        inscricaoEstadual: 'ISENTO',
      );

      final json = destinatario.toJson();

      expect(json['cpfCnpj'], equals('98765432000100'));
      expect(json['razaoSocial'], equals('Cliente LTDA'));
      expect(json['email'], equals('cliente@email.com'));
      expect(json['endereco'], isNotNull);
      expect(json['inscricaoEstadual'], equals('ISENTO'));
    });

    test('deve deserializar de JSON corretamente', () {
      final json = {
        'cpfCnpj': '98765432000100',
        'razaoSocial': 'Cliente LTDA',
        'email': 'cliente@email.com',
        'endereco': {
          'codigoCidade': 3550308,
          'descricaoCidade': 'São Paulo',
          'estado': 'SP',
          'logradouro': 'Rua Teste',
          'numero': '123',
          'bairro': 'Centro',
          'cep': '01310100',
        },
        'telefone': '11987654321',
      };

      final destinatario = Destinatario.fromJson(json);

      expect(destinatario.cpfCnpj, equals('98765432000100'));
      expect(destinatario.telefone, equals('11987654321'));
      expect(destinatario.endereco.codigoCidade, equals(3550308));
    });

    test('deve ser imutável com copyWith', () {
      const destinatario = Destinatario(
        cpfCnpj: '98765432000100',
        razaoSocial: 'Cliente LTDA',
        email: 'cliente@email.com',
        endereco: enderecoTeste,
      );

      final novoDestinatario = destinatario.copyWith(
        razaoSocial: 'Novo Cliente LTDA',
      );

      expect(destinatario.razaoSocial, equals('Cliente LTDA'));
      expect(novoDestinatario.razaoSocial, equals('Novo Cliente LTDA'));
      expect(novoDestinatario.cpfCnpj, equals('98765432000100'));
    });
  });
}
