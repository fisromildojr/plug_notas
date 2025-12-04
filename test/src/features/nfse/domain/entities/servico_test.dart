import 'package:flutter_test/flutter_test.dart';
import 'package:plug_notas/src/features/nfse/domain/entities/servico.dart';

void main() {
  group('ISS', () {
    test('deve criar ISS com valores mínimos', () {
      const iss = ISS(
        aliquota: 5.0,
        valor: 50.0,
      );

      expect(iss.aliquota, equals(5.0));
      expect(iss.valor, equals(50.0));
      expect(iss.exigibilidade, equals('1')); // Valor padrão
      expect(iss.retido, isFalse); // Valor padrão
    });

    test('deve criar ISS com valores customizados', () {
      const iss = ISS(
        aliquota: 5.0,
        valor: 50.0,
        exigibilidade: '3',
        retido: true,
      );

      expect(iss.exigibilidade, equals('3'));
      expect(iss.retido, isTrue);
    });

    test('deve serializar para JSON', () {
      const iss = ISS(
        aliquota: 5.0,
        valor: 50.0,
      );

      final json = iss.toJson();

      expect(json['aliquota'], equals(5.0));
      expect(json['valor'], equals(50.0));
      expect(json['exigibilidade'], equals('1'));
      expect(json['retido'], isFalse);
    });
  });

  group('Servico', () {
    test('deve criar Servico completo', () {
      const servico = Servico(
        codigo: '01.07',
        discriminacao: 'Desenvolvimento de software',
        cnae: '6201501',
        valorServico: 1000.0,
        iss: ISS(
          aliquota: 5.0,
          valor: 50.0,
        ),
      );

      expect(servico.codigo, equals('01.07'));
      expect(servico.discriminacao, equals('Desenvolvimento de software'));
      expect(servico.cnae, equals('6201501'));
      expect(servico.valorServico, equals(1000.0));
      expect(servico.iss.aliquota, equals(5.0));
      expect(servico.aliquotaPis, isNull);
      expect(servico.aliquotaCofins, isNull);
      expect(servico.valorDeducoes, isNull);
      expect(servico.valorDescontos, isNull);
    });

    test('deve criar Servico com valores opcionais', () {
      const servico = Servico(
        codigo: '01.07',
        discriminacao: 'Desenvolvimento de software',
        cnae: '6201501',
        valorServico: 1000.0,
        iss: ISS(
          aliquota: 5.0,
          valor: 50.0,
        ),
        aliquotaPis: 0.65,
        aliquotaCofins: 3.0,
        valorDeducoes: 100.0,
        valorDescontos: 50.0,
      );

      expect(servico.aliquotaPis, equals(0.65));
      expect(servico.aliquotaCofins, equals(3.0));
      expect(servico.valorDeducoes, equals(100.0));
      expect(servico.valorDescontos, equals(50.0));
    });

    test('deve serializar para JSON corretamente', () {
      const servico = Servico(
        codigo: '01.07',
        discriminacao: 'Desenvolvimento',
        cnae: '6201501',
        valorServico: 1000.0,
        iss: ISS(
          aliquota: 5.0,
          valor: 50.0,
        ),
        aliquotaPis: 0.65,
      );

      final json = servico.toJson();

      expect(json['codigo'], equals('01.07'));
      expect(json['discriminacao'], equals('Desenvolvimento'));
      expect(json['cnae'], equals('6201501'));
      expect(json['valorServico'], equals(1000.0));
      expect(json['iss'], isNotNull);
      expect(json['aliquotaPis'], equals(0.65));
    });

    test('deve deserializar de JSON corretamente', () {
      final json = {
        'codigo': '01.07',
        'discriminacao': 'Desenvolvimento',
        'cnae': '6201501',
        'valorServico': 1000.0,
        'iss': {
          'aliquota': 5.0,
          'valor': 50.0,
          'exigibilidade': '1',
          'retido': false,
        },
        'aliquotaPis': 0.65,
        'aliquotaCofins': 3.0,
      };

      final servico = Servico.fromJson(json);

      expect(servico.codigo, equals('01.07'));
      expect(servico.valorServico, equals(1000.0));
      expect(servico.iss.aliquota, equals(5.0));
      expect(servico.aliquotaPis, equals(0.65));
    });

    test('deve ser imutável', () {
      const servico = Servico(
        codigo: '01.07',
        discriminacao: 'Desenvolvimento',
        cnae: '6201501',
        valorServico: 1000.0,
        iss: ISS(
          aliquota: 5.0,
          valor: 50.0,
        ),
      );

      final novoServico = servico.copyWith(valorServico: 2000.0);

      expect(servico.valorServico, equals(1000.0));
      expect(novoServico.valorServico, equals(2000.0));
    });
  });
}
