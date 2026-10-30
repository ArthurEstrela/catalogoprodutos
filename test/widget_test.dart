import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:catalogoprodutos/main.dart';

void main() {
  testWidgets('Cadastra um produto e mostra o SnackBar', (tester) async {
    await tester.pumpWidget(const MyApp());

    // A tela principal mostra os produtos iniciais
    expect(find.text('Catálogo de Produtos'), findsOneWidget);
    expect(find.text('Notebook'), findsOneWidget);

    // Clicar em Comprar mostra o SnackBar
    await tester.tap(find.text('Comprar').first);
    await tester.pump();
    expect(find.text('Notebook foi adicionado ao carrinho!'), findsOneWidget);

    // Abre a tela de cadastro pelo FloatingActionButton
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.text('Cadastrar Produto'), findsOneWidget);

    // Preenche os campos e cadastra
    await tester.enterText(find.byType(TextFormField).at(0), 'Boneca');
    await tester.enterText(find.byType(TextFormField).at(1), '45,00');
    await tester.tap(find.text('Eletrônicos'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Brinquedos').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cadastrar'));
    await tester.pumpAndSettle();

    // Voltou para a lista com o produto novo e os antigos
    await tester.dragUntilVisible(
      find.text('Boneca'),
      find.byType(ListView),
      const Offset(0, -200),
    );
    expect(find.text('Boneca'), findsOneWidget);
    expect(find.byIcon(Icons.toys), findsOneWidget);
  });
}
