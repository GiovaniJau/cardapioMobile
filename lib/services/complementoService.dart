import 'dart:convert';

import 'package:cardapio_mobile/valueObject/complementosPorCategoria.dart';
import 'package:http/http.dart' as http;

class ComplementoService {

  static Future<List<ComplementosPorCategoria>> getAll() async {
    late List<ComplementosPorCategoria> _listaComplemento = [];
    final response = await http.get(Uri.parse("https://www.glix.web.br.com/flutter/cardapio/phps/listaComplemento.php"));
    final items = json.decode(response.body).cast<Map<String, dynamic>>();

    _listaComplemento = items.map<ComplementosPorCategoria>((json) {
      return ComplementosPorCategoria.fromJson(json);
    }).toList();

    return _listaComplemento;
  }

  static Future<List<ComplementosPorCategoria>> getPorCategoria({required int categoriaId}) async {
    late List<ComplementosPorCategoria> _listaComplemento = [];
    final response = await http.get(Uri.parse("https://www.glix.web.br.com/flutter/cardapio/phps/listaComplementoPorCategoria.php?categoria=$categoriaId"));
    final items = json.decode(response.body).cast<Map<String, dynamic>>();

    _listaComplemento = items.map<ComplementosPorCategoria>((json) {
      return ComplementosPorCategoria.fromJson(json);
    }).toList();

    return _listaComplemento;
  }

}