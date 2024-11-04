// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomePageStore on _HomePageStore, Store {
  late final _$nomeAtom = Atom(name: '_HomePageStore.nome', context: context);

  @override
  String get nome {
    _$nomeAtom.reportRead();
    return super.nome;
  }

  @override
  set nome(String value) {
    _$nomeAtom.reportWrite(value, super.nome, () {
      super.nome = value;
    });
  }

  late final _$ingredientesResultadoAtom = Atom(name: '_HomePageStore.ingredientesResultado', context: context);

  @override
  List<String> get ingredientesResultado {
    _$ingredientesResultadoAtom.reportRead();
    return super.ingredientesResultado;
  }

  @override
  set ingredientesResultado(List<String> value) {
    _$ingredientesResultadoAtom.reportWrite(value, super.ingredientesResultado, () {
      super.ingredientesResultado = value;
    });
  }

  late final _$_HomePageStoreActionController = ActionController(name: '_HomePageStore', context: context);

  @override
  List<String> realizarPedido(String pedido) {
    final _$actionInfo = _$_HomePageStoreActionController.startAction(name: '_HomePageStore.realizarPedido');
    try {
      return super.realizarPedido(pedido);
    } finally {
      _$_HomePageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void processarPedido(BuildContext context) {
    final _$actionInfo = _$_HomePageStoreActionController.startAction(name: '_HomePageStore.processarPedido');
    try {
      return super.processarPedido(context);
    } finally {
      _$_HomePageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removerIngrediente(int index) {
    final _$actionInfo = _$_HomePageStoreActionController.startAction(name: '_HomePageStore.removerIngrediente');
    try {
      return super.removerIngrediente(index);
    } finally {
      _$_HomePageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
nome: ${nome},
ingredientesResultado: ${ingredientesResultado}
    ''';
  }
}
