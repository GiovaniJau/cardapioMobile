import 'package:cardapio_mobile/screens/carrinho/metodos_carrinho.dart';
import 'package:flutter/material.dart';

AppBar carrinhoAppBar() {
  return AppBar(
    elevation: 0,
    actions: <Widget>[
      TextButton(
          onPressed: () {
            LimparCarrinho();
          },
          child: const Text("Limpar", style: TextStyle(color: Colors.cyanAccent),))
    ],
  );
}