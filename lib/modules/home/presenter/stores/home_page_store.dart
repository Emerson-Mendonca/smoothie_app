import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'home_page_store.g.dart';

class HomePageStore = _HomePageStore with _$HomePageStore;

abstract class _HomePageStore with Store {
  @observable
  String nome = '';

  final TextEditingController pedidoController = TextEditingController();

  @observable
  List<String> ingredientesResultado = [];

  AnimationController? controller;
  Animation<double>? animation;

  final Map<String, List<String>> cardapioSmoothies = {
    "clássico": ["🍓 morango", "🍌 banana", "🍍 abacaxi", "🥭 manga", "🍑 pêssego", "🍯 mel", "🧊 gelo", "🥛 iogurte"],
    "forest Berry": ["🍓 morango", "🍇 framboesa", "🫐 mirtilo", "🍯 mel", "🧊 gelo", "🥛 iogurte"],
    "freezie": ["🍇 amora", "🫐 mirtilo", "🍇 groselha preta", "🍇 suco de uva", "🍦 iogurte congelado"],
    "freenie": ["🍏 maçã verde", "🥝 kiwi", "🍋 limão", "🥑 abacate", "🌱 espinafre", "🧊 gelo", "🍏 suco de maçã"],
    "fegan Delight": ["🍓 morango", "🍈 maracujá", "🍍 abacaxi", "🥭 manga", "🍑 pêssego", "🧊 gelo", "🥛 leite de soja"],
    "apenas sobremesas": ["🍌 banana", "🍦 sorvete", "🍫 chocolate", "🥜 amendoim", "🍒 cereja"]
  };

  @action
  List<String> realizarPedido(String pedido) {
    List<String> partes = pedido.toLowerCase().split(", ");
    String nomeSmoothie = partes[0];

    if (!cardapioSmoothies.containsKey(nomeSmoothie)) {
      return ["Não foi possível encontrado no cardápio."];
    }

    List<String> ingredientes = List.from(cardapioSmoothies[nomeSmoothie]!);

    List<String> ingredientesSemEmoji = ingredientes.map((ingrediente) {
      return ingrediente.replaceAll(RegExp(r'[^\w\s]'), '').trim();
    }).toList();

    for (int i = 1; i < partes.length; i++) {
      String operacao = partes[i];

      if (operacao.startsWith("+")) {
        String ingrediente = operacao.substring(1).trim();
        if (!ingredientesSemEmoji.contains(ingrediente)) {
          ingredientes.add("✅ $ingrediente");
          ingredientesSemEmoji.add(ingrediente);
        }
      } else if (operacao.startsWith("-")) {
        String ingrediente = operacao.substring(1).trim();
        int index = ingredientesSemEmoji.indexOf(ingrediente);
        if (index != -1) {
          ingredientes.removeAt(index);
          ingredientesSemEmoji.removeAt(index);
        }
      }
    }

    return ingredientes;
  }

  @action
  void processarPedido(BuildContext context) {
    FocusScope.of(context).unfocus();
    ingredientesResultado = realizarPedido(pedidoController.text);

    if (ingredientesResultado.isNotEmpty) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _startAnimation();
      });
    }
  }

  @action
  void removerIngrediente(int index) {
    String ingrediente = ingredientesResultado[index].replaceAll(RegExp(r'[^\w\s]'), '').trim();

    if (!ingrediente.contains('No foi possvel encontrado no cardpio')) {
      pedidoController.text = '${pedidoController.text} -${ingrediente}, ';
    }

    ingredientesResultado.removeAt(index);

    if (ingredientesResultado.isNotEmpty) {
      _startAnimation();
    }
  }

  void _startAnimation() {
    controller?.forward().then((_) {
      controller?.reverse();
    });
  }
}
