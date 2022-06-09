class Complemento_rel_Categoria {
  int? categoriaId;
  int? complementoId;

  Complemento_rel_Categoria({
    this.categoriaId,
    this.complementoId
  });

  factory Complemento_rel_Categoria.fromJson(Map<String, dynamic> json) => Complemento_rel_Categoria(
    categoriaId: json["categoriaId_"],
    complementoId: json["complementoId_"]
  );

  Map<String, dynamic> toJson() => {
    "categoriaId_": categoriaId,
    "complementoId_": complementoId
  };

}