// ignore_for_file: must_be_immutable

import 'package:cardapio_mobile/models/produto.dart';
import 'package:cardapio_mobile/screens/complemento/lista_complemento.dart';
import 'package:flutter/material.dart';

class ComplementoQuantidade extends StatelessWidget {
  final Produto produto;

  const ComplementoQuantidade({Key? key, required this.produto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListaComplemento(produtoSelecionado: produto);
  }

}
