import 'package:flutter/material.dart';
import '../models/produto.dart';
import 'cadastro_page.dart';

// Tela principal: mostra a lista de produtos
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Lista de produtos que já começa com alguns itens de exemplo
  final List<Produto> produtos = [
    Produto(nome: 'Notebook', preco: 3500.00, categoria: 'Eletrônicos'),
    Produto(nome: 'Camiseta', preco: 59.90, categoria: 'Roupas'),
    Produto(nome: 'Chocolate', preco: 8.50, categoria: 'Alimentos'),
    Produto(nome: 'Dom Casmurro', preco: 34.90, categoria: 'Livros'),
    Produto(nome: 'Bola de Futebol', preco: 120.00, categoria: 'Esportes'),
  ];

  // Mostra o SnackBar avisando que o produto foi para o carrinho
  void adicionarAoCarrinho(Produto produto) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${produto.nome} foi adicionado ao carrinho!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Abre a tela de cadastro e espera o produto que vai voltar dela
  Future<void> abrirCadastro() async {
    final novoProduto = await Navigator.push<Produto>(
      context,
      MaterialPageRoute(builder: (context) => const CadastroPage()),
    );

    // Se o usuário voltou sem cadastrar, novoProduto vem null
    if (novoProduto != null) {
      setState(() {
        produtos.add(novoProduto); // adiciona sem apagar os outros
      });
    }
  }

  // Formata o preço no estilo brasileiro (ex: R$ 59,90)
  String formatarPreco(double preco) {
    return 'R\$ ${preco.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Produtos'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: produtos.isEmpty
          ? const Center(child: Text('Nenhum produto cadastrado.'))
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: produtos.length,
              itemBuilder: (context, index) {
                final produto = produtos[index];

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                  child: ListTile(
                    // Ícone de acordo com a categoria
                    leading: CircleAvatar(
                      child: Icon(iconeDaCategoria(produto.categoria)),
                    ),
                    title: Text(
                      produto.nome,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${formatarPreco(produto.preco)}\n${produto.categoria}',
                    ),
                    isThreeLine: true,
                    // Clicar no produto também adiciona ao carrinho
                    onTap: () => adicionarAoCarrinho(produto),
                    trailing: ElevatedButton(
                      onPressed: () => adicionarAoCarrinho(produto),
                      child: const Text('Comprar'),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: abrirCadastro,
        tooltip: 'Cadastrar produto',
        child: const Icon(Icons.add),
      ),
    );
  }
}
