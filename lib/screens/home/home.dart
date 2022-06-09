import 'package:cardapio_mobile/screens/home/components/app_bar.dart';
import 'package:cardapio_mobile/screens/home/components/body.dart';
import 'package:cardapio_mobile/screens/home/components/drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: const Body(),
      drawer: drawer(context),
    );
  }
}
