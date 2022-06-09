class Vendas {
  int? id;
  DateTime? datahora;
  int? statusId;
  double? valorTotal;

  Vendas({
    this.id,
    this.datahora,
    this.statusId,
    this.valorTotal
  });

  factory Vendas.fromJson(Map<String, dynamic> json) => Vendas(
    id: json["id_"],
    datahora: DateTime.tryParse(json["datahora_"]),
    statusId: json["statusId_"],
    valorTotal: json["valorTotal_"],
  );

  Map<String, dynamic> toJson() => {
    "id_": id,
    "datahora_": datahora,
    "statusId_": statusId,
    "valorTotal_": valorTotal,
  };

}