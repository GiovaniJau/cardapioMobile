// ignore_for_file: must_be_immutable

import 'package:cardapio_mobile/screens/carrinho/components/app_bar.dart';
import 'package:cardapio_mobile/screens/carrinho/components/body.dart';
import 'package:flutter/material.dart';

class CarrinhoScreen extends StatelessWidget {
  const CarrinhoScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: carrinhoAppBar(),
      body: const Body()
    );
  }
}
