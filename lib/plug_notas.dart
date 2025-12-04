/// Pacote Flutter para integração com API PlugNotas
///
/// Facilita a emissão de NF-e, NFC-e e NFS-e seguindo Clean Architecture
library plug_notas;

// Core
export 'src/core/config/plug_notas_environment.dart';
export 'src/core/constants/plug_notas_constants.dart';
export 'src/core/error/exceptions.dart';
export 'src/features/nfe/domain/entities/destinatario.dart';
export 'src/features/nfe/domain/entities/emitente.dart';
export 'src/features/nfe/domain/entities/endereco.dart';
export 'src/features/nfe/domain/entities/item.dart';
// Entidades de Domínio - NF-e
export 'src/features/nfe/domain/entities/nfe.dart';
export 'src/features/nfe/domain/entities/pagamento.dart';
export 'src/features/nfe/domain/entities/tributos.dart';
// Entidades de Domínio - NFS-e
export 'src/features/nfse/domain/entities/nfse.dart';
export 'src/features/nfse/domain/entities/prestador.dart';
export 'src/features/nfse/domain/entities/servico.dart';
export 'src/features/nfse/domain/entities/tomador.dart';
// Fachada Principal
export 'src/plug_notas_base.dart';
