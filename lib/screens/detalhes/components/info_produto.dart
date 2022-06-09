// ignore_for_file: must_be_immutable

import 'package:cardapio_mobile/models/produto.dart';
import 'package:flutter/material.dart';

class InfoProduto extends StatelessWidget {
  Produto produto;

  InfoProduto({Key? key, required this.produto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Text(produto.detalhes!.isEmpty ? produto.descricao! : produto.detalhes!,
            maxLines: 5, style: const TextStyle(height: 1.5),
          ),
        ],
      ),
    );
  }
}
