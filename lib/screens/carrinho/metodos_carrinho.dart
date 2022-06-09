import 'package:cardapio_mobile/screens/carrinho/components/notificacao_carrinho.dart';
import 'package:cardapio_mobile/screens/home/components/app_bar.dart';
import 'package:cardapio_mobile/valueObject/produtoCarrinho.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> LimparCarrinho() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();

  NotificacaoCarrinhoState.totalItensCarrinho = 0;
  streamCarrinho.add(NotificacaoCarrinhoState.totalItensCarrinho);
}

Function? ConfirmaLimparCarrinho(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text('LIMPAR CARRINHO DE COMPRAS'),
            content: const Text(
                'Par limpar todos os dados do carrinho de compras, clique no botão <Limpar>;\n\nATENÇÃO: Esta ação não poderá ser disfeita após clicar no botão <Limpar>.'),
            actions: <Widget>[
              ElevatedButton(
                child: const Text("Cancelar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: const Text("Limpar"),
                onPressed: () {
                  LimparCarrinho();
                  Navigator.of(context).pop();
                },
              )
            ]
        );
      }
  );
}


Future<void> ConsultarCarrinho() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  late final String listaCarrinhoString;
  late List<ProdutoCarrinho> listaCarrinho = [];

  if (prefs.containsKey("CarrinhoCompras")) {
    listaCarrinhoString = prefs.getString('CarrinhoCompras')!;

    listaCarrinho = ProdutoCarrinho.decode(listaCarrinhoString);

    NotificacaoCarrinhoState.totalItensCarrinho = listaCarrinho.length;
    streamCarrinho.add(NotificacaoCarrinhoState.totalItensCarrinho);
  }
}