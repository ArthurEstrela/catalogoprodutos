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

  // Categoria escolhida no DropdownButton (começa nula para obrigar a seleção)
  String? _categoriaSelecionada;

  @override
  void dispose() {
    _nomeController.dispose();
    _precoController.dispose();
    super.dispose();
  }

  void _salvar() {
    // Valida todos os campos do Form aplicando as regras de cada um
    if (_formKey.currentState!.validate()) {
      // Troca vírgula por ponto para o double.parse funcionar (ex: 10,50)
      final preco = double.parse(_precoController.text.replaceAll(',', '.'));

      final novoProduto = Produto(
        nome: _nomeController.text.trim(),
        preco: preco,
        categoria: _categoriaSelecionada!,
      );

      // Volta para a tela principal levando o novo produto
      Navigator.pop(context, novoProduto);
    } else {
      // Mostra um aviso caso algum campo não tenha passado na validação
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos corretamente para cadastrar!'),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        ),
      );
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
              // Campo do nome com conjunto de regras de validação
              TextFormField(
                controller: _nomeController,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'Nome do produto',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.label),
                ),
                validator: (valor) {
                  final texto = valor?.trim() ?? '';
                  if (texto.isEmpty) {
                    return 'Informe o nome do produto';
                  }
                  if (texto.length < 3) {
                    return 'O nome deve ter pelo menos 3 caracteres';
                  }
                  if (double.tryParse(texto) != null) {
                    return 'O nome não pode conter apenas números';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo do preço com conjunto de regras de validação
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
                  final texto = valor?.trim() ?? '';
                  if (texto.isEmpty) {
                    return 'Informe o preço do produto';
                  }
                  final preco = double.tryParse(texto.replaceAll(',', '.'));
                  if (preco == null) {
                    return 'Digite um valor numérico válido (ex: 19,90)';
                  }
                  if (preco <= 0) {
                    return 'O preço deve ser maior que zero';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Seleção da categoria com DropdownButton validado pelo Form
              FormField<String>(
                initialValue: _categoriaSelecionada,
                validator: (valor) {
                  if (valor == null || valor.isEmpty) {
                    return 'Selecione uma categoria para o produto';
                  }
                  if (!categorias.contains(valor)) {
                    return 'Categoria inválida';
                  }
                  return null;
                },
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Categoria',
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.category),
                      errorText: state.errorText,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _categoriaSelecionada,
                        hint: const Text('Selecione uma categoria'),
                        isExpanded: true,
                        isDense: true,
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
                            _categoriaSelecionada = novoValor;
                          });
                          state.didChange(novoValor);
                        },
                      ),
                    ),
                  );
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
