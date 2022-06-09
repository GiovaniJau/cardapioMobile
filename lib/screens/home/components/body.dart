import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cardapio_mobile/screens/home/components/lista_categoria.dart';
import 'package:cardapio_mobile/screens/home/components/lista_produtos.dart';

StreamController<int> streamController = StreamController<int>();

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const ListaCategoria(),
        ListaProdutos(streamController.stream)
      ],
    );
  }
}