// ignore_for_file: must_be_immutable

import 'package:cardapio_mobile/models/produto.dart';
import 'package:flutter/material.dart';

class TopoDetalhes extends StatelessWidget {
  Produto produto;

  TopoDetalhes({Key? key, required this.produto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var urlImagem = produto.imagens?[0].urlImagem ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(produto.descricao!, maxLines: 2,
            style: const TextStyle(fontSize: 25, color: Colors.white),
          ),
          const SizedBox(height: 40),
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(text: "Preço \n"),
                    TextSpan(text: "R\$ ${produto.precoVenda!.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 25)
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 120),
              Expanded(
                child: Hero(
                  tag: produto.id!,
                  child: urlImagem.isEmpty
                      ? Image.asset('assets/images/burger.png', fit: BoxFit.fill)
                      : Image.network(urlImagem, fit: BoxFit.fill)
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
