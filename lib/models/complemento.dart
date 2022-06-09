
class Complemento {
  int? id;
  String? descricao;
  double? preco;
  bool? ativo;

  Complemento({
    this.id,
    this.descricao,
    this.preco,
    this.ativo
  });

  factory Complemento.fromJson(Map<String, dynamic> json) => Complemento(
    id: json["id_"],
    descricao: json["descricao_"],
    preco: double.tryParse(json["preco_"]),
    ativo: json["ativo_"],
  );

  Map<String, dynamic> toJson() => {
    "id_": id,
    "descricao_": descricao,
    "preco_": preco,
    "ativo_": ativo,
  };

}