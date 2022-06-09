// ignore_for_file: must_be_immutable

import 'package:cardapio_mobile/screens/carrinho/components/lista_Carrinho.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: <Widget>[
          const Center(
            child: Text('Carrinho de Compras', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 20),
          Expanded(
            flex: 1,
              child: Container(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                height: size.height * 0.85,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24)
                    )
                ),
                child: const ListaCarrinho(),
              ),
            ),
          ]
        )
    );
  }
}
