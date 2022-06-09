import 'dart:async';

import 'package:cardapio_mobile/models/produto.dart';
import 'package:cardapio_mobile/screens/detalhes/datalhes.dart';
import 'package:cardapio_mobile/services/produtoService.dart';
import 'package:flutter/material.dart';

class ListaProdutos extends StatefulWidget {
  final Stream<int> stream;
  const ListaProdutos(this.stream, {Key? key}) : super(key: key);

  @override
  ListaProdutosState createState() => ListaProdutosState();
}

class ListaProdutosState extends State<ListaProdutos> {
  static int filtroCategoriaId = 0;

  static List<Produto> listaProdutos = [];
  static List<Produto> listaProdutosFiltrados = [];
  int selectedIndex = 0;
  bool _progress = false;

  static changeCategoria(int filtroCategoriaId) {
    if (filtroCategoriaId > 0) {
      listaProdutosFiltrados = listaProdutos.where((x) => x.categoriaId == filtroCategoriaId).toList();
    } else {
      listaProdutosFiltrados = listaProdutos;
    }
  }

  refreshScreen() {
    setState(() {});
  }

  Future<void> _getProdutos(int categoriaId) async {
    setState(() {
      _progress = true;
    });

    listaProdutos = await ProdutoService.getAll(categoriaId: categoriaId);
    listaProdutosFiltrados = listaProdutos;

    setState(() {
      _progress = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _getProdutos(0);
    changeCategoria(filtroCategoriaId);

    widget.stream.listen((index) {
      refreshScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: _progress ? _rowProgress() : SizedBox(
        height: 25,
        child: GridView.builder(
            itemCount: listaProdutosFiltrados.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.65
            ),
            itemBuilder: (context, index) => buildCartaoProduto(index, context)
        ),
      ),
    ));
  }

  Column _rowProgress() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const <Widget> [
        Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }

  Widget buildCartaoProduto(int index, BuildContext context) {
    var urlImagem = listaProdutosFiltrados[index].imagens?[0].urlImagem ?? '';

    return Container(
      margin: const EdgeInsets.only(left: 10, right: 15, top: 20, bottom: 0),
      child: Material(
        elevation: 6.0,
        color: Colors.white,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetalhesScreen(produto: listaProdutosFiltrados[index],)
              )
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  padding: const EdgeInsets.all(15),
                  child: Hero(
                    tag: listaProdutosFiltrados[index].id!,
                    child: urlImagem.isEmpty
                        ? Image.asset('assets/images/burger.png', fit: BoxFit.fill)
                        : Image.network(urlImagem, fit: BoxFit.cover)

                  ),
                ),
                Text(listaProdutosFiltrados[index].descricao!, maxLines: 2, overflow: TextOverflow.visible, style: const TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),),
                const Divider(color: Colors.black,),
                Text("R\$ ${listaProdutosFiltrados[index].precoVenda!.toStringAsFixed(2)}", maxLines: 1, overflow: TextOverflow.visible, style: const TextStyle(color: Colors.red, fontSize: 18.0, fontWeight: FontWeight.bold),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
