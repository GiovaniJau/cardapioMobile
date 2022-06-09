import 'package:cardapio_mobile/screens/carrinho/carrinho.dart';
import 'package:cardapio_mobile/screens/carrinho/metodos_carrinho.dart';
import 'package:cardapio_mobile/screens/home/components/app_bar.dart';
import 'package:cardapio_mobile/valueObject/produtoCarrinho.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificacaoCarrinho extends StatefulWidget {
  final Stream<int> stream;
  const NotificacaoCarrinho(this.stream, {Key? key}) : super(key: key);

  @override
  NotificacaoCarrinhoState createState() => NotificacaoCarrinhoState();
}

class NotificacaoCarrinhoState extends State<NotificacaoCarrinho> {
  static int totalItensCarrinho = 0;

  late final String listaCarrinhoString;
  late List<ProdutoCarrinho> listaCarrinho = [];

  refreshScreen() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    widget.stream.listen((index) {
      refreshScreen();
    });

    // Metodo do carrinho de compras que verifica se existe algum item no
    // carrinho e atualiza o contador da notficação
    ConsultarCarrinho();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CarrinhoScreen()
          )
        )
      },
      child: SizedBox(
        width: 55,
        child: Stack(
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.shopping_cart, size: 30, color: Colors.blue),
            ),
            Positioned(
              top: 5,
              right: 10,
              child: Container(
                padding: const EdgeInsets.all(2.0),
                width: 20,
                height: 20,
                decoration: totalItensCarrinho > 0
                    ? const BoxDecoration(color: Colors.red, shape: BoxShape.circle)
                    : null,
                child: FittedBox(
                  child: totalItensCarrinho > 0
                      ? Text(totalItensCarrinho.toString(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                      : null
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}