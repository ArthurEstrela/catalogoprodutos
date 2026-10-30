# Catálogo de Produtos

Aplicativo feito em Flutter para a **Atividade 5: Lista**.

O app mostra uma lista de produtos e permite cadastrar novos produtos, que são adicionados ao catálogo na hora.

## Funcionalidades

- Lista de produtos usando `List` e `ListView.builder`
- Cada produto aparece em um `Card` com:
  - ícone da categoria
  - nome
  - preço
  - botão **Comprar**
- `FloatingActionButton` que abre a tela **Cadastrar Produto**
- Cadastro com nome, preço e categoria (escolhida em um `DropdownButton`)
- O novo produto é adicionado à lista sem apagar os que já existem
- Ao clicar em um produto (ou no botão Comprar), aparece um `SnackBar` avisando que ele foi adicionado ao carrinho

## Categorias

| Categoria   | Ícone           |
|-------------|-----------------|
| Eletrônicos | `devices`       |
| Roupas      | `checkroom`     |
| Alimentos   | `fastfood`      |
| Livros      | `menu_book`     |
| Esportes    | `sports_soccer` |
| Brinquedos  | `toys`          |

## Estrutura

```
lib/
├── main.dart                 # inicia o app
├── models/
│   └── produto.dart          # classe Produto, categorias e ícones
└── screens/
    ├── home_page.dart        # tela principal com a lista
    └── cadastro_page.dart    # tela de cadastro
```

## Como executar

```bash
flutter pub get
flutter run
```

## Autor

Arthur Estrela
