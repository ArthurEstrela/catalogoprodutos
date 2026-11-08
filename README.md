# Catálogo de Produtos

Aplicativo feito em Flutter para as **Atividades 5 e 6: Lista, Formulário e Validação**.

O app mostra uma lista de produtos e permite cadastrar novos produtos com validação de formulário, atualizando dinamicamente o catálogo.

## Funcionalidades

- Lista de produtos usando `List` e `ListView.builder`
- Cada produto aparece em um `Card` com:
  - ícone da categoria
  - nome
  - preço
  - botão **Comprar**
- `FloatingActionButton` que abre a tela **Cadastrar Produto**
- Cadastro com nome, preço e categoria (escolhida em um `DropdownButton`)
- Validação de todos os campos através do widget `Form`, exibindo mensagens de erro em cada campo e um aviso caso algum campo não seja validado:
  - **Nome**: obrigatório, mínimo de 3 caracteres e não pode conter apenas números
  - **Preço**: obrigatório, valor numérico válido e maior que zero
  - **Categoria**: seleção obrigatória de uma categoria válida no `DropdownButton`
- O novo produto é adicionado à lista sem substituir os que já existem
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
    └── cadastro_page.dart    # tela de cadastro com validação via Form
```

## Como executar

```bash
flutter pub get
flutter run
```

## Autor

Arthur Estrela
