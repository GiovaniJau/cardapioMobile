import 'package:cardapio_mobile/models/produto.dart';
import 'package:cardapio_mobile/screens/detalhes/components/botao_comprar.dart';
import 'package:cardapio_mobile/services/complementoService.dart';
import 'package:cardapio_mobile/valueObject/complementosPorCategoria.dart';
import 'package:cardapio_mobile/valueObject/produtoCarrinho.dart';
import 'package:flutter/material.dart';

class ListaComplemento extends StatefulWidget {
  final Produto produtoSelecionado;

  const ListaComplemento({Key? key, required this.produtoSelecionado}) : super(key: key);

  @override
  _ListaComplementoState createState() => _ListaComplementoState(produtoSelecionado);
}

class _ListaComplementoState extends State<ListaComplemento> {
  final Produto produtoSelecionado;

  _ListaComplementoState(this.produtoSelecionado);

  List<ComplementosPorCategoria> result = [];
  List<ComplementosPorCategoria> listaComplementos = [];
  int quantidadeItem = 0;
  bool _progress = false;

  late final ProdutoCarrinho _itemCarrinho = ProdutoCarrinho();
  late final List<ComplementosPorCategoria> _complementos = [];

  // Criamos um controlador para o texto das observações
  final observacaoController = TextEditingController();

  Future<void> _getComplementosPorCategorias() async {
    setState(() {
      _progress = true;
    });

    result = await ComplementoService.getAll();
    listaComplementos = result.where((element) => element.categoriaId == produtoSelecionado.categoriaId).toList();

    setState(() {
      _progress = false;
    });
  }

  void quantidadeMais(ComplementosPorCategoria item) {
    setState(() {
      item.quantidade = item.quantidade != null ? item.quantidade! + 1 : 1;

      if (_complementos.isNotEmpty) {
        int index = _complementos.indexWhere((x) => x.complementoId == item.complementoId);

        if (index >= 0) {
          _complementos[index].quantidade = item.quantidade;
        } else {
          _complementos.add(item);
        }
      } else {
        _complementos.add(item);
      }
    });
  }

  void quantidadeMenos(ComplementosPorCategoria item) {
    setState(() {
      item.quantidade = item.quantidade! - 1;

      if (_complementos.isNotEmpty) {
        int index = _complementos.indexWhere((x) => x.complementoId == item.complementoId);

        if (index >= 0) {
          if (item.quantidade == 0) {
            _complementos.removeAt(index);
          } else {
            _complementos[index].quantidade = item.quantidade;
          }
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _getComplementosPorCategorias();

    // Iniciamos o ouvinte do campo de observações
    observacaoController.addListener(_setObservacaoChanges);
  }

  void _setObservacaoChanges() {
    _itemCarrinho.observacao = observacaoController.text;
  }

  ProdutoCarrinho populateItemCarrinho() {
    _itemCarrinho.produtoId = produtoSelecionado.id;
    _itemCarrinho.descricao = produtoSelecionado.descricao;
    _itemCarrinho.quantidade = 1;
    _itemCarrinho.preco = produtoSelecionado.precoVenda;
    _itemCarrinho.urlImagem = produtoSelecionado.imagens![0].urlImagem!.isNotEmpty ? produtoSelecionado.imagens![0].urlImagem! : '';
    _itemCarrinho.complementos = _complementos;

    return _itemCarrinho;
  }

  @override
  void dispose() {
    // Não esquecer de fechar o ouvinte ao sair da tela
    observacaoController.dispose();
    super.dispose();
  }

  /*
    Widget para ficar como exemplo de como criar um widget com scroll, incluindo objetos roláveis (ListView)
    e objetos não roláveis (Containers, Columns, etc)
   */
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()
            ),
            child: _progress ? _rowProgress() : Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: listaComplementos.length + 1,
                    itemBuilder: (context, index) {
                      return (index < listaComplementos.length)
                          ?
                      ListTile(
                          title: Text(listaComplementos[index].descricao!),
                          subtitle: listaComplementos[index].preco! > 0
                              ? Text(
                              listaComplementos[index].preco!.toStringAsFixed(
                                  2))
                              : const Text("Grátis"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
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
                                      if (listaComplementos[index].quantidade! >= 1) {
                                        quantidadeMenos(listaComplementos[index]);
                                      }
                                    },
                                    child: const Icon(
                                        Icons.remove, color: Colors.blue,
                                        size: 20)
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10),
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: Colors.blue)
                                ),
                                child: Align(
                                  child:
                                  listaComplementos[index].quantidade != null && listaComplementos[index].quantidade! > 0
                                  ? Text(listaComplementos[index].quantidade!.toString())
                                  : Text(0.toString()),
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
                                    quantidadeMais(listaComplementos[index]);
                                  },
                                  child: const Icon(
                                    Icons.add, color: Colors.blue, size: 25,),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {}
                      )
                          :
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.all(10),
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.blue),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(14))
                        ),
                        child: TextField(
                          controller: observacaoController,
                          maxLines: 3,
                          autofocus: false,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(
                              hintText: 'Ex: Sem cebola'),
                          enabled: true,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20,),
                  BotaoComprar(produtoCarrinho: populateItemCarrinho())
                ]
            )
        )
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
