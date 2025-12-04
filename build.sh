# Build Runner Script
# Gera código Freezed e JSON Serializable

echo "🔧 Gerando código com build_runner..."
echo ""

# Limpa arquivos gerados anteriormente
echo "🧹 Limpando arquivos antigos..."
flutter pub run build_runner clean

# Gera novos arquivos
echo ""
echo "🏗️  Gerando novos arquivos..."
flutter pub run build_runner build --delete-conflicting-outputs

echo ""
echo "✅ Código gerado com sucesso!"
echo ""
echo "📁 Arquivos .freezed.dart e .g.dart foram criados"
