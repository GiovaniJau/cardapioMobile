import 'package:cardapio_mobile/models/Imagem.dart';
import 'package:cardapio_mobile/models/complemento.dart';

class Produto {
  int? id;
  String? descricao;
  String? detalhes;
  String? codigoBarras;
  int? categoriaId;
  String? unidade;
  bool? controlaEstoque;
  int? estoque;
  bool? permiteComplementos;
  double? precoVenda;
  bool? ativo;
  List<Complemento>? complementos;
  List<Imagem>? imagens;

  Produto({
    this.id,
    this.descricao,
    this.detalhes,
    this.codigoBarras,
    this.categoriaId,
    this.unidade,
    this.controlaEstoque,
    this.estoque,
    this.permiteComplementos,
    this.precoVenda,
    this.ativo,
    this.complementos,
    this.imagens
  });

  factory Produto.fromJson(Map<String, dynamic> json) => Produto(
    id: json["id_"],
    descricao: json["descricao_"],
    detalhes: json["detalhes_"],
    codigoBarras: json["codigoBarras_"],
    categoriaId: json["categoriaId_"],
    unidade: json["unidade_"],
    controlaEstoque: json["controlaEstoque_"],
    estoque: json["estoque_"],
    permiteComplementos: json["permiteComplementos_"],
    precoVenda: double.tryParse(json["precoVenda_"]),
    ativo: json["ativo_"],
    complementos: List<Complemento>.from(json["complementos_"].map((x) => Complemento.fromJson(x))),
    imagens: List<Imagem>.from(json["imagens_"].map((x) => Imagem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id_": id,
    "descricao_": descricao,
    "detalhes_": detalhes,
    "codigoBarras_": codigoBarras,
    "categoriaId_": categoriaId,
    "unidade_": unidade,
    "controlaEstoque_": controlaEstoque,
    "estoque_": estoque,
    "permiteComplementos_": permiteComplementos,
    "precoVenda_": precoVenda,
    "ativo_": ativo,
    "complementos_": List<dynamic>.from(complementos!.map((x) => x.toJson())),
    "imagens_": List<dynamic>.from(imagens!.map((x) => x.toJson()))
  };
}

