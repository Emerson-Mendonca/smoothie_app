import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smoothie_app/modules/home/presenter/page/home_page.dart';
import 'package:smoothie_app/modules/home/presenter/page/menu_page.dart';
import 'package:smoothie_app/modules/home/presenter/stores/home_page_store.dart';

void main() {
  group('HomePage Widget Tests', () {
    late HomePageStore homePageStore;

    setUp(() {
      homePageStore = HomePageStore();
    });

    testWidgets('Deve navegar para MenuPage ao pressionar o botão de info', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: HomePage(homePageStore: homePageStore),
      ));

      final button = find.byKey(Key("lista_cardapio"));
      expect(button, findsOneWidget);

      await tester.tap(button);
      await tester.pumpAndSettle();

      expect(find.byType(MenuPage), findsOneWidget);
    });

    testWidgets('Deve processar o pedido e exibir ingredientes na lista', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: HomePage(homePageStore: homePageStore),
      ));

      // Configura o pedido e processa
      homePageStore.pedidoController.text = "Clássico";
      await tester.tap(find.text('Realizar Pedido'));

      await tester.pumpAndSettle();

      // Verifica se os ingredientes foram atualizados
      expect(homePageStore.ingredientesResultado, isNotEmpty);
      expect(homePageStore.ingredientesResultado, contains("🍓 morango"));
    });

    testWidgets(
        'Deve processar o pedido e exibir ingredientes na lista '
        'E adicionar mais ingredientes na lista ', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: HomePage(homePageStore: homePageStore),
      ));

      homePageStore.pedidoController.text = "Clássico, +chocolate, ";
      await tester.tap(find.text('Realizar Pedido'));

      await tester.pumpAndSettle();

      expect(homePageStore.ingredientesResultado, isNotEmpty);
      expect(homePageStore.ingredientesResultado, contains("✅ chocolate"));
    });

    testWidgets(
        'Deve processar o pedido e exibir ingredientes na lista '
        'E retira ingredientes na lista ', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: HomePage(homePageStore: homePageStore),
      ));

      homePageStore.pedidoController.text = "Clássico, -morango, ";
      await tester.tap(find.text('Realizar Pedido'));

      await tester.pumpAndSettle();

      expect(homePageStore.ingredientesResultado, isNotEmpty);
      expect(homePageStore.ingredientesResultado, isNot(contains("🍓 morango")));
    });


    testWidgets(
        'Deve processar o pedido e exibir ingredientes na lista '
        'Sem o estar na lista de cardapio. ', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: HomePage(homePageStore: homePageStore),
      ));

      homePageStore.pedidoController.text = "Pão, ";
      await tester.tap(find.text('Realizar Pedido'));

      await tester.pumpAndSettle();

      expect(homePageStore.ingredientesResultado, isNotEmpty);
      expect(homePageStore.ingredientesResultado, contains("Não foi possível encontrado no cardápio."));
    });

    testWidgets('Deve remover ingrediente da lista ao deslizar para o lado', (WidgetTester tester) async {
      homePageStore.pedidoController.text = "Clássico";
      await tester.pumpWidget(MaterialApp(
        home: HomePage(homePageStore: homePageStore),
      ));

      await tester.tap(find.text('Realizar Pedido'));

      await tester.pumpAndSettle();

      // Verifica a lista de ingredientes antes da remoção
      expect(homePageStore.ingredientesResultado.length, greaterThan(0));

      // Desliza para remover o primeiro ingrediente
      await tester.drag(find.text(homePageStore.ingredientesResultado[0]), Offset(500, 0));
      await tester.pumpAndSettle();

      // Verifica se o ingrediente foi removido
      expect(homePageStore.ingredientesResultado.length, lessThan(8));
    });
  });
}
