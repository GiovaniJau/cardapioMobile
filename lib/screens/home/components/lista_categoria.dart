import 'package:cardapio_mobile/models/categoria.dart';
import 'package:cardapio_mobile/screens/home/components/body.dart';
import 'package:cardapio_mobile/screens/home/components/lista_produtos.dart';
import 'package:cardapio_mobile/services/categoriaService.dart';
import 'package:flutter/material.dart';

class ListaCategoria extends StatefulWidget {
  const ListaCategoria({Key? key}) : super(key: key);

  @override
  _ListaCategoriaState createState() => _ListaCategoriaState();
}

class _ListaCategoriaState extends State<ListaCategoria> {
  List<Categoria> result = [];
  List<String> categorias = [];
  int selectedIndex = 0;
  bool _progress = false;

  Future<void> _getCategorias() async {
    setState(() {
      _progress = true;
    });

    result = await CategoriaService.getAll();

    for (int i = 0; i < result.length; i++) {
      categorias.add(result[i].descricao!);
    }

    setState(() {
      _progress = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _getCategorias();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: _progress ? _rowProgress() : SizedBox(
        height: 25,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categorias.length,
          itemBuilder: (context, index) => buildCategoria(index),
        ),
      ),
    );
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

  Widget buildCategoria(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;

          ListaProdutosState.filtroCategoriaId = (index >= 0 ? result[index].id! : 0);
          ListaProdutosState.changeCategoria(index >= 0 ? result[index].id! : 0);
          streamController.add(index);
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              categorias[index],
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: selectedIndex == index ? Colors.blue : Colors.blueGrey
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              height: 2,
              width: 30,
              color: selectedIndex == index ? Colors.green : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}