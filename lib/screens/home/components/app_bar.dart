import 'dart:async';

import 'package:flutter/material.dart';
import '../../carrinho/components/notificacao_carrinho.dart';

StreamController<int> streamCarrinho = StreamController<int>();

AppBar appBar(BuildContext context) {
  return AppBar(
    centerTitle: true,
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.blue),
    title: RichText(
      text: const TextSpan(
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        children: [
          TextSpan(
            text: "Cardápio",
            style: TextStyle(color: Colors.blue),
          ),
          TextSpan(
            text: "Mobile",
            style: TextStyle(color: Colors.green),
          ),
        ]
      ),
    ),
    actions: <Widget>[
      NotificacaoCarrinho(streamCarrinho.stream)
    ],
  );
}