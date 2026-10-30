import 'package:flutter/material.dart';
import '../models/produto.dart';

// Tela para cadastrar um novo produto
class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _precoController = TextEditingController();

  // Categoria escolhida no DropdownButton (começa com a primeira)
  String _categoriaSelecionada = categorias[0];

  @override
  void dispose() {
    _nomeController.dispose();
    _precoController.dispose();
    super.dispose();
  }

  void _salvar() {
    // Só continua se os campos estiverem válidos
    if (_formKey.currentState!.validate()) {
      // Troca vírgula por ponto para o double.parse funcionar (ex: 10,50)
      final preco = double.parse(_precoController.text.replaceAll(',', '.'));

      final novoProduto = Produto(
        nome: _nomeController.text.trim(),
        preco: preco,
        categoria: _categoriaSelecionada,
      );

      // Volta para a tela principal levando o novo produto
      Navigator.pop(context, novoProduto);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Produto'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Campo do nome
              TextFormField(
                controller: _nomeController,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'Nome do produto',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.label),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe o nome do produto';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo do preço
              TextFormField(
                controller: _precoController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Preço',
                  hintText: 'Ex: 19,90',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe o preço';
                  }
                  final preco = double.tryParse(valor.replaceAll(',', '.'));
                  if (preco == null || preco <= 0) {
                    return 'Digite um preço válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Seleção da categoria com DropdownButton
              const Text('Categoria', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 4),
              DropdownButton<String>(
                value: _categoriaSelecionada,
                isExpanded: true,
                items: categorias.map((categoria) {
                  return DropdownMenuItem<String>(
                    value: categoria,
                    child: Row(
                      children: [
                        Icon(iconeDaCategoria(categoria)),
                        const SizedBox(width: 10),
                        Text(categoria),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (novoValor) {
                  setState(() {
                    _categoriaSelecionada = novoValor!;
                  });
                },
              ),
              const SizedBox(height: 24),

              // Botão para confirmar o cadastro
              ElevatedButton.icon(
                onPressed: _salvar,
                icon: const Icon(Icons.check),
                label: const Text('Cadastrar'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
