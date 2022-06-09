import 'package:cardapio_mobile/valueObject/produtoCarrinho.dart';

class CarrinhoDeCompras {
  DateTime? dataHora;
  String? mesaComanda;
  List<ProdutoCarrinho>? produtos;

  CarrinhoDeCompras({
    this.dataHora,
    this.mesaComanda,
    this.produtos
  });

  factory CarrinhoDeCompras.fromJson(Map<String, dynamic> json) => CarrinhoDeCompras(
    dataHora: json["categoriaId_"],
    mesaComanda: json["complementoId_"],
    produtos: List<ProdutoCarrinho>.from(json["produtos_"].map((x) => ProdutoCarrinho.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "datahora_": dataHora,
    "mesaComanda_": mesaComanda,
    "produtos_": List<dynamic>.from(produtos!.map((x) => x.toJson()))
  };

}

