import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({
    super.key,
  });

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with SingleTickerProviderStateMixin {
  final Map<String, List<String>> cardapioSmoothies = {
    "Clássico": ["🍓 morango", "🍌 banana", "🍍 abacaxi", "🥭 manga", "🍑 pêssego", "🍯 mel", "🧊 gelo", "🥛 iogurte"],
    "Forest Berry": ["🍓 morango", "🍇 framboesa", "🫐 mirtilo", "🍯 mel", "🧊 gelo", "🥛 iogurte"],
    "Freezie": ["🍇 amora", "🫐 mirtilo", "🍇 groselha preta", "🍇 suco de uva", "🍦 iogurte congelado"],
    "Greenie": ["🍏 maçã verde", "🥝 kiwi", "🍋 limão", "🥑 abacate", "🌱 espinafre", "🧊 gelo", "🍏 suco de maçã"],
    "Vegan Delight": ["🍓 morango", "🍈 maracujá", "🍍 abacaxi", "🥭 manga", "🍑 pêssego", "🧊 gelo", "🥛 leite de soja"],
    "Apenas sobremesas": ["🍌 banana", "🍦 sorvete", "🍫 chocolate", "🥜 amendoim", "🍒 cereja"]
  };

  @override
  void initState() {
    super.initState();
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Cardapio:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: cardapioSmoothies.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      cardapioSmoothies.keys.elementAt(index),
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      cardapioSmoothies.values.elementAt(index).join('\n'),
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
