import 'package:cardapio_mobile/screens/home/components/app_bar.dart';
import 'package:cardapio_mobile/screens/carrinho/components/notificacao_carrinho.dart';
import 'package:cardapio_mobile/valueObject/produtoCarrinho.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BotaoComprar extends StatefulWidget {
  final ProdutoCarrinho produtoCarrinho;

  const BotaoComprar({Key? key, required this.produtoCarrinho}) : super(key: key);

  @override
  _BotaoComprarState createState() => _BotaoComprarState(produtoCarrinho);
}

class _BotaoComprarState extends State<BotaoComprar> {
  final ProdutoCarrinho produtoCarrinho;

  _BotaoComprarState(this.produtoCarrinho);

  @override
  void initState() {
    super.initState();

    produtoCarrinho.quantidade = 1;
  }

  void salvarCarrinho() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? listaCarrinhoString = prefs.getString('CarrinhoCompras');
    List<ProdutoCarrinho> listaCarrinho = [];

    print(listaCarrinhoString);

    if (listaCarrinhoString != null) {
      listaCarrinho = ProdutoCarrinho.decode(listaCarrinhoString);
    }

    listaCarrinho.add(produtoCarrinho);
    final String encodeListaCarrinho = ProdutoCarrinho.encode(listaCarrinho);

    await prefs.setString("CarrinhoCompras", encodeListaCarrinho);

    print(encodeListaCarrinho);
  }

  void quantidadeMais(ProdutoCarrinho item) {
    setState(() {
      item.quantidade = item.quantidade! + 1;
    });
  }

  void quantidadeMenos(ProdutoCarrinho item) {
    setState(() {
      item.quantidade = item.quantidade! - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.blue)
            ),
            child: InkWell(
                onTap: () {
                  quantidadeMenos(produtoCarrinho);
                },
                child: const Icon(Icons.remove, color: Colors.blue, size: 25)
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.blue)
            ),
            child: Align(
              child: Text(produtoCarrinho.quantidade!.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),),
            ),
          ),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.blue)
            ),
            child: InkWell(
              onTap: () {
                quantidadeMais(produtoCarrinho);
              },
              child: const Icon(Icons.add, color: Colors.blue, size: 25,),
            ),
          ),

          const SizedBox(width: 10,),
          Container(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                      onTap: () {
                        NotificacaoCarrinhoState.totalItensCarrinho++;
                        streamCarrinho.add(NotificacaoCarrinhoState.totalItensCarrinho);

                        salvarCarrinho();

                        Navigator.of(context).pop();
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Icon(Icons.shopping_cart, color: Colors.white,),
                                SizedBox(width: 10,),
                                Text("Adicionar ao Carrinho", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))
                              ]
                          )
                      )
                  )
              )
          )
        ]
    );
  }

}
