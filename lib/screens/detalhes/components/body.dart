import 'package:cardapio_mobile/models/produto.dart';
import 'package:cardapio_mobile/screens/carrinho/components/complemento_quantidade.dart';
import 'package:cardapio_mobile/screens/detalhes/components/info_produto.dart';
import 'package:cardapio_mobile/screens/detalhes/components/topo_detalhes.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  Produto produto;

  Body({Key? key, required this.produto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: size.height * 0.25),
          padding: EdgeInsets.only(
            top: size.height * 0.02,
            left: 20,
            right: 20,
            bottom: 10
          ),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25)
              )
          ),
          child: Column(
            children: <Widget>[
              InfoProduto(produto: produto),
              const SizedBox(height: 10),

              const SizedBox(
                width: double.infinity,
                height: 30,
                child: Card(
                  elevation: 10,
                  child: Text("Escolha e adicione o(s) complemento(s):", textAlign: TextAlign.center),
                )
              ),
              const SizedBox(height: 5),
              ComplementoQuantidade(produto: produto),
              const SizedBox(height: 10),

            ],
          ),
        ),
        TopoDetalhes(produto: produto,)
      ]
    );
  }
}