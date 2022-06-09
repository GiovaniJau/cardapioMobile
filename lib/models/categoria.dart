class Categoria {
  int? id;
  String? descricao;
  String? impressora;
  bool? ativo;

  Categoria({
    this.id,
    this.descricao,
    this.impressora,
    this.ativo
  });

  factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
    id: json["id_"],
    descricao: json["descricao_"],
    impressora: json["impressora_"],
    ativo: json["ativo_"],
  );

  Map<String, dynamic> toJson() => {
    "id_": id,
    "descricao_": descricao,
    "impressora_": impressora,
    "ativo_": ativo,
  };

}