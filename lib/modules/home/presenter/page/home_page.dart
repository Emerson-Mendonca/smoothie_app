import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:smoothie_app/modules/home/presenter/page/menu_page.dart';
import 'package:smoothie_app/modules/home/presenter/stores/home_page_store.dart';

class HomePage extends StatefulWidget {
  final HomePageStore homePageStore;

  const HomePage({
    super.key,
    required this.homePageStore,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    initAnimation(this);
    super.initState();
  }

  void initAnimation(TickerProvider vsync) {
    widget.homePageStore.controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: vsync,
    );

    widget.homePageStore.animation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(
        parent: widget.homePageStore.controller!,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smoothie App'),
        leading: IconButton(
          key: Key("lista_cardapio"),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => MenuPage(),
              ),
              (route) => true,
            );
          },
          icon: Icon(Icons.info),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: widget.homePageStore.pedidoController,
              decoration: const InputDecoration(
                labelText: 'Digite o pedido (ex: Clássico, +chocolate, -morango)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                widget.homePageStore.processarPedido(context);
                widget.homePageStore.controller?.forward(from: 0);
              },
              child: const Text('Realizar Pedido'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Ingredientes Atualizados:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Observer(
              builder: (_) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: widget.homePageStore.ingredientesResultado.length,
                    itemBuilder: (context, index) {
                      final ingrediente = widget.homePageStore.ingredientesResultado[index];
                      return Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.startToEnd,
                        onDismissed: (direction) {
                          widget.homePageStore.removerIngrediente(index);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('$ingrediente removido do pedido'),
                            ),
                          );
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        child: AnimatedBuilder(
                          animation: widget.homePageStore.controller!,
                          builder: (context, child) {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.green, width: 1.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              transform: index == 0
                                  ? Matrix4.translationValues(
                                      widget.homePageStore.animation!.value * (index % 2 == 0 ? 1 : -1),
                                      0,
                                      0,
                                    )
                                  : Matrix4.identity(),
                              child: ListTile(
                                title: Text(ingrediente),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
