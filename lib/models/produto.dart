import 'package:flutter/material.dart';

// Classe que representa um produto do catálogo
class Produto {
  String nome;
  double preco;
  String categoria;

  Produto({
    required this.nome,
    required this.preco,
    required this.categoria,
  });
}

// Lista com as categorias disponíveis (usada no DropdownButton)
const List<String> categorias = [
  'Eletrônicos',
  'Roupas',
  'Alimentos',
  'Livros',
  'Esportes',
  'Brinquedos',
];

// Função que devolve o ícone de acordo com a categoria do produto
IconData iconeDaCategoria(String categoria) {
  switch (categoria) {
    case 'Eletrônicos':
      return Icons.devices;
    case 'Roupas':
      return Icons.checkroom;
    case 'Alimentos':
      return Icons.fastfood;
    case 'Livros':
      return Icons.menu_book;
    case 'Esportes':
      return Icons.sports_soccer;
    case 'Brinquedos':
      return Icons.toys;
    default:
      return Icons.shopping_bag;
  }
}
