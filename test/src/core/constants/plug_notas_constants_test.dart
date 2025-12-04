import 'package:flutter_test/flutter_test.dart';
import 'package:plug_notas/src/core/constants/plug_notas_constants.dart';

void main() {
  group('PlugNotasConstants', () {
    group('Endpoints', () {
      test('deve ter endpoint correto para NFe', () {
        expect(PlugNotasConstants.nfeEndpoint, equals('/nfe'));
      });

      test('deve ter endpoint correto para NFCe', () {
        expect(PlugNotasConstants.nfceEndpoint, equals('/nfce'));
      });

      test('deve ter endpoint correto para NFSe', () {
        expect(PlugNotasConstants.nfseEndpoint, equals('/nfse'));
      });

      test('deve ter endpoint correto para certificado', () {
        expect(PlugNotasConstants.certificadoEndpoint, equals('/certificado'));
      });
    });

    group('Timeouts', () {
      test('deve ter timeout de conexão de 30 segundos', () {
        expect(PlugNotasConstants.connectTimeout, equals(30000));
      });

      test('deve ter timeout de recebimento de 30 segundos', () {
        expect(PlugNotasConstants.receiveTimeout, equals(30000));
      });

      test('deve ter timeout de envio de 30 segundos', () {
        expect(PlugNotasConstants.sendTimeout, equals(30000));
      });
    });

    group('Headers', () {
      test('deve ter header correto para API Key', () {
        expect(PlugNotasConstants.apiKeyHeader, equals('x-api-key'));
      });

      test('deve ter header correto para Content-Type', () {
        expect(PlugNotasConstants.contentTypeHeader, equals('Content-Type'));
      });

      test('deve ter content type JSON correto', () {
        expect(PlugNotasConstants.contentTypeJson, equals('application/json'));
      });
    });

    group('Meios de Pagamento', () {
      test('deve ter código correto para dinheiro', () {
        expect(PlugNotasConstants.pagamentoDinheiro, equals('01'));
      });

      test('deve ter código correto para cheque', () {
        expect(PlugNotasConstants.pagamentoCheque, equals('02'));
      });

      test('deve ter código correto para cartão de crédito', () {
        expect(PlugNotasConstants.pagamentoCartaoCredito, equals('03'));
      });

      test('deve ter código correto para cartão de débito', () {
        expect(PlugNotasConstants.pagamentoCartaoDebito, equals('04'));
      });

      test('deve ter código correto para PIX', () {
        expect(PlugNotasConstants.pagamentoPix, equals('17'));
      });

      test('deve ter código correto para boleto', () {
        expect(PlugNotasConstants.pagamentoBoleto, equals('15'));
      });

      test('deve ter código correto para sem pagamento', () {
        expect(PlugNotasConstants.pagamentoSemPagamento, equals('90'));
      });

      test('deve ter código correto para outros', () {
        expect(PlugNotasConstants.pagamentoOutro, equals('99'));
      });
    });
  });
}
