// ignore_for_file: must_be_immutable

import 'package:cardapio_mobile/models/produto.dart';
import 'package:cardapio_mobile/screens/detalhes/components/app_bar.dart';
import 'package:cardapio_mobile/screens/detalhes/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetalhesScreen extends StatelessWidget {
  Produto produto;

  DetalhesScreen({Key? key, required this.produto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.blue,
        appBar: detalhesAppBar(),
        body: Body(produto: produto),
      )
    );
  }
}
