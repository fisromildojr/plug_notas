# Contribuindo para Plug Notas

Obrigado por considerar contribuir para o pacote Plug Notas! 

## Como Contribuir

1. **Fork o repositório**
2. **Crie uma branch** para sua feature (`git checkout -b feature/nova-funcionalidade`)
3. **Faça suas alterações** seguindo os padrões do projeto
4. **Execute os testes** (quando disponíveis)
5. **Commit suas mudanças** (`git commit -m 'feat: adiciona nova funcionalidade'`)
6. **Push para a branch** (`git push origin feature/nova-funcionalidade`)
7. **Abra um Pull Request**

## Padrões de Código

### Arquitetura

Este projeto segue **Clean Architecture** com a seguinte estrutura:

```
lib/
├── src/
│   ├── core/           # Configurações, erros, constantes
│   ├── features/       # Features divididas por domínio
│   │   ├── */domain/   # Entidades e repositórios (interfaces)
│   │   └── */data/     # Models, datasources e implementações
│   └── plug_notas_base.dart  # Fachada pública
└── plug_notas.dart  # Exports públicos
```

### Princípios SOLID

- **S** - Single Responsibility: Cada classe tem uma única responsabilidade
- **O** - Open/Closed: Aberto para extensão, fechado para modificação
- **L** - Liskov Substitution: Interfaces devem ser substituíveis
- **I** - Interface Segregation: Interfaces específicas e coesas
- **D** - Dependency Inversion: Dependa de abstrações, não implementações

### Convenções

- Use **Freezed** para entidades e models imutáveis
- Use **json_serializable** para serialização
- Documente métodos públicos com DartDoc (`///`)
- Mantenha cobertura de testes acima de 80%
- Use `const` sempre que possível
- Prefira trailing commas para melhor formatação

### Commits

Siga o padrão [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` - Nova funcionalidade
- `fix:` - Correção de bug
- `docs:` - Alterações na documentação
- `refactor:` - Refatoração sem mudança de comportamento
- `test:` - Adição ou correção de testes
- `chore:` - Alterações em arquivos de build, CI, etc.

## Build Runner

Após alterações em classes Freezed:

```bash
# Linux/Mac
chmod +x build.sh
./build.sh

# Windows
flutter pub run build_runner build --delete-conflicting-outputs
```

## Questões e Sugestões

Sinta-se à vontade para abrir issues para:

- 🐛 Relatar bugs
- 💡 Sugerir novas funcionalidades
- 📚 Melhorar a documentação
- ❓ Tirar dúvidas

## Código de Conduta

Seja respeitoso e construtivo em todas as interações.
