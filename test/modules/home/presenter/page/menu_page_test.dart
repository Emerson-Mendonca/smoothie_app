import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smoothie_app/modules/home/presenter/page/menu_page.dart';

void main() {
  testWidgets('Deve exibir o cardápio de smoothies', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MenuPage()));

    expect(find.text('Smoothie App'), findsOneWidget);
    
    expect(find.text('Cardapio:'), findsOneWidget);

    expect(find.text('Clássico'), findsOneWidget);

  });
}
