class ComplementosPorCategoria {
  int? categoriaId;
  int? complementoId;
  String? descricao;
  double? preco;
  int? quantidade;
  bool? ativo;

  ComplementosPorCategoria({
    this.categoriaId,
    this.complementoId,
    this.descricao,
    this.preco,
    this.quantidade,
    this.ativo
  });

  factory ComplementosPorCategoria.fromJson(Map<String, dynamic> json) => ComplementosPorCategoria(
    categoriaId: json["categoriaId_"],
    complementoId: json["complementoId_"],
    descricao: json["descricao_"],
    preco: double.tryParse(json["preco_"]),
    quantidade: json["quantidade_"],
    ativo: json["ativo_"],
  );

  Map<String, dynamic> toJson() => {
    "categoriaId_": categoriaId,
    "complementoId_": complementoId,
    "descricao_": descricao,
    "preco_": preco!.toStringAsFixed(2),
    "quantidade_": quantidade ?? 0,
    "ativo_": ativo,
  };

}