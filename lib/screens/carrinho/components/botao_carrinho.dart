import 'package:cardapio_mobile/screens/home/components/app_bar.dart';
import 'package:cardapio_mobile/screens/carrinho/components/notificacao_carrinho.dart';
import 'package:flutter/material.dart';

class BotaoCarrinho extends StatelessWidget {
  const BotaoCarrinho({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(Icons.shopping_cart, color: Colors.white,),
                SizedBox(width: 10,),
                Text("Ver Carrinho", style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold, fontSize: 18
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
