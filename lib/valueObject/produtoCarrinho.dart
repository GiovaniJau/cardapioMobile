import 'dart:convert';
import 'package:cardapio_mobile/valueObject/complementosPorCategoria.dart';

class ProdutoCarrinho {
  int? produtoId;
  String? descricao;
  int? quantidade;
  double? preco;
  String? observacao;
  String? urlImagem;
  List<ComplementosPorCategoria>? complementos;

  ProdutoCarrinho({
    this.produtoId,
    this.descricao,
    this.quantidade,
    this.preco,
    this.observacao,
    this.urlImagem,
    this.complementos
  });

  factory ProdutoCarrinho.fromJson(Map<String, dynamic> json) => ProdutoCarrinho(
    produtoId: json["categoriaId_"],
    descricao: json["descricao_"],
    quantidade: json["quantidade_"],
    preco: double.tryParse(json["preco_"]),
    observacao: json["observacao_"],
    urlImagem: json["urlImagem_"],
    complementos: json["complementos_"] != null ? List<ComplementosPorCategoria>.from(json["complementos_"].map((x) => ComplementosPorCategoria.fromJson(x))) : null,
  );

  Map<String, dynamic> toJson() => {
    "produtoId_": produtoId,
    "descricao_": descricao,
    "quantidade_": quantidade,
    "preco_": preco,
    "observacao_": observacao,
    "urlImagem_": urlImagem,
    "complementos_": List<dynamic>.from(complementos!.map((x) => x.toJson()))
  };

  // Métodos para salvar uma lista de objetos na SharedPreferences como uma lista de strings

  // Primeiro mapeamos objeto como um array de strings
  static Map<String, dynamic> toMap(ProdutoCarrinho item) => {
    "produtoId_": item.produtoId,
    "descricao_": item.descricao,
    "quantidade_": item.quantidade,
    "preco_": item.preco!.toStringAsFixed(2),
    "observacao_": item.observacao,
    "urlImagem_": item.urlImagem,
    "complementos_": List<dynamic>.from(item.complementos!.map((x) => x.toJson()))
  };

  // depois convertemos como uma string json
  // Esta string já pode ser enviada direto para a SharedPreferences
  static String encode(List<ProdutoCarrinho> itens) => json.encode(
    itens.map<Map<String, dynamic>>((item) => ProdutoCarrinho.toMap(item)).toList(),
  );

  // Para recuperar a lista de objetos que está armazenada como string na SharedPreferences,
  // basta executar o metodo decode
  static List<ProdutoCarrinho> decode(String itens) => (
    json.decode(itens) as List<dynamic>).map<ProdutoCarrinho>((item) => ProdutoCarrinho.fromJson(item)
  ).toList();

}