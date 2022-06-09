import 'package:cardapio_mobile/screens/carrinho/metodos_carrinho.dart';
import 'package:cardapio_mobile/valueObject/complementosPorCategoria.dart';
import 'package:cardapio_mobile/valueObject/produtoCarrinho.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListaCarrinho extends StatefulWidget {
  const ListaCarrinho({Key? key}) : super(key: key);

  @override
  _ListaCarrinhoState createState() => _ListaCarrinhoState();
}

class _ListaCarrinhoState extends State<ListaCarrinho> {
  late final String listaCarrinhoString;
  late List<ProdutoCarrinho> listaCarrinho = [];

  late int totalItens = 0;
  late double totalCarrinho = 0.0;

  bool _progress = false;

  Future<void> _parseListObject() async {
    setState(() {
      _progress = true;
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey("CarrinhoCompras")) {
      listaCarrinhoString = prefs.getString('CarrinhoCompras')!;

      listaCarrinho = ProdutoCarrinho.decode(listaCarrinhoString);

      listaCarrinho.forEach((item) {
        double totalAdicionais = 0.0;

        if (item.complementos != null) {
          item.complementos!.forEach((compl) {
            totalAdicionais += compl.quantidade! * compl.preco!;
          });
        }

        totalItens += item.quantidade!;
        totalCarrinho += (item.quantidade! * item.preco!) + totalAdicionais;
      });
    }

    setState(() {
      _progress = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _parseListObject();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics()
      ),
      child: _progress ? _rowProgress() : Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            itemCount: listaCarrinho.length,
            itemBuilder: (context, index) {
              double totalAdicional = 0;
              if (listaCarrinho[index].complementos!.isNotEmpty) {
                for (int i = 0; i < listaCarrinho[index].complementos!.length; i++) {
                    totalAdicional += listaCarrinho[index].complementos![i].quantidade! * listaCarrinho[index].complementos![i].preco!;
                }
              }
              double valorTotal = (listaCarrinho[index].quantidade! *
                  listaCarrinho[index].preco!) + totalAdicional;

              return ExpansionTileCard(
                initialElevation: 5,
                initialPadding: const EdgeInsets.symmetric(vertical: 10),
                elevation: 5,
                borderRadius: BorderRadius.circular(20.0),
                contentPadding: const EdgeInsets.all(10),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(listaCarrinho[index].descricao!),
                    (totalAdicional > 0)
                    ?
                    Text('(${listaCarrinho[index]
                      .quantidade!} X ${listaCarrinho[index].preco!
                      .toStringAsFixed(2)}) + ${totalAdicional.toStringAsFixed(2)} = ${valorTotal.toStringAsFixed(2)}')
                    :
                    Text('${listaCarrinho[index]
                      .quantidade!} X ${listaCarrinho[index].preco!
                      .toStringAsFixed(2)} = ${valorTotal.toStringAsFixed(2)}')
                  ],
                ),
                leading: listaCarrinho[index].urlImagem!.isEmpty
                    ? Image.asset('assets/images/burger.png', fit: BoxFit.fill)
                    : Image.network(listaCarrinho[index].urlImagem!, fit: BoxFit.cover),
                children: [
                  const Divider(thickness: 1.0, height: 1.0,),
                  expandedContent(context, listaCarrinho[index])
                ],
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.blue, width: 5.0)
            ),
            margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("TOTAL DO CARRINHO R\$  ${totalCarrinho.toStringAsFixed(2)}", style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 18))
                  ]
                )
              )
            )
          ),
          const SizedBox(width: 10,),
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10)
            ),
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  ConfirmaLimparCarrinho(context);
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(Icons.send_outlined, color: Colors.white,),
                      SizedBox(width: 15,),
                      Text("Confirmar e Enviar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24))
                    ]
                  )
                )
              )
            )
          )
        ]
      )
    );
  }

  expandedContent(BuildContext context, ProdutoCarrinho item) {
    if (item.complementos!.isNotEmpty) {
      item.complementos!.sort((a, b) {
        return a.preco!.compareTo(b.preco!);
      });
    } else {
      ComplementosPorCategoria semComplementos = ComplementosPorCategoria();
      semComplementos.complementoId = 0;
      semComplementos.categoriaId = 0;
      semComplementos.descricao = "Sem complementos";
      semComplementos.preco = 0.0;
      semComplementos.quantidade = 0;
      semComplementos.ativo = true;
      item.complementos!.add(semComplementos);
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics()
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      itemCount: item.complementos!.length,
      itemBuilder: (context, index2) {
        double totalAdicional = item.complementos![index2].quantidade! * item.complementos![index2].preco!;

        return ListTile(
          title: Text(item.complementos![index2].descricao!),
          subtitle: item.complementos![index2].descricao! == "Sem complementos"
            ?
            Text('')
            :
            Text('${item.complementos![index2]
              .quantidade!} X ${item.complementos![index2].preco!
              .toStringAsFixed(2)} = ${totalAdicional.toStringAsFixed(2)}')
        );
      }
    );
  }

  _rowProgress() {
    return Stack(
      children: const <Widget>[
        Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}