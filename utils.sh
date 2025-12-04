#!/bin/bash

# 🎯 Comandos Úteis - Plug Notas

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║         COMANDOS ÚTEIS - PACOTE PLUG NOTAS                 ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""

# Função para mostrar menu
show_menu() {
    echo "Escolha uma opção:"
    echo ""
    echo "  1) 📦 Instalar dependências"
    echo "  2) 🔨 Gerar código Freezed (build_runner)"
    echo "  3) 🧹 Limpar código gerado"
    echo "  4) ✅ Verificar erros (analyze)"
    echo "  5) 🎨 Formatar código"
    echo "  6) 📊 Verificar versões desatualizadas"
    echo "  7) 🚀 Executar exemplo"
    echo "  8) 📖 Ver estrutura do projeto"
    echo "  9) 🔍 Ver logs de build"
    echo "  0) ❌ Sair"
    echo ""
    echo -n "Opção: "
}

# Loop do menu
while true; do
    show_menu
    read option
    echo ""

    case $option in
        1)
            echo "📦 Instalando dependências..."
            flutter pub get
            echo ""
            ;;
        2)
            echo "🔨 Gerando código Freezed..."
            flutter pub run build_runner build --delete-conflicting-outputs
            echo ""
            ;;
        3)
            echo "🧹 Limpando código gerado..."
            flutter pub run build_runner clean
            echo ""
            ;;
        4)
            echo "✅ Verificando erros..."
            flutter analyze
            echo ""
            ;;
        5)
            echo "🎨 Formatando código..."
            dart format lib/ example/
            echo ""
            ;;
        6)
            echo "📊 Verificando versões desatualizadas..."
            flutter pub outdated
            echo ""
            ;;
        7)
            echo "🚀 Executando exemplo..."
            echo "⚠️  ATENÇÃO: Configure sua API Key antes!"
            echo ""
            dart run example/main.dart
            echo ""
            ;;
        8)
            echo "📖 Estrutura do projeto:"
            tree -L 3 -I 'build|.dart_tool|.idea|*.g.dart|*.freezed.dart' || ls -R
            echo ""
            ;;
        9)
            echo "🔍 Verificando logs recentes..."
            if [ -f ".dart_tool/build/generated/build_runner/*.log" ]; then
                tail -n 50 .dart_tool/build/generated/build_runner/*.log
            else
                echo "Nenhum log encontrado. Execute o build_runner primeiro."
            fi
            echo ""
            ;;
        0)
            echo "👋 Até logo!"
            exit 0
            ;;
        *)
            echo "❌ Opção inválida!"
            echo ""
            ;;
    esac

    echo "Pressione ENTER para continuar..."
    read
    clear
done
