
class Imagem {
  int? id;
  int? produtoId;
  String? urlImagem;
  bool? ativo;

  Imagem({
    this.id,
    this.produtoId,
    this.urlImagem,
    this.ativo
  });

  factory Imagem.fromJson(Map<String, dynamic> json) => Imagem(
    id: json["id_"],
    produtoId: json["produtoId_"],
    urlImagem: json["urlImagem_"],
    ativo: json["ativo_"],
  );

  Map<String, dynamic> toJson() => {
    "id_": id,
    "produtoId_": produtoId,
    "urlImagem_": urlImagem,
    "ativo_": ativo,
  };

}