import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:cardapio_mobile/models/categoria.dart';

class CategoriaService {

  static Future<List<Categoria>> getAll() async {
    late List<Categoria> _listaCategoria = [];
    final response = await http.get(Uri.parse("https://www.glix.web.br.com/flutter/cardapio/phps/listaCategorias.php"));
    final items = json.decode(response.body).cast<Map<String, dynamic>>();

    _listaCategoria = items.map<Categoria>((json) {
      return Categoria.fromJson(json);
    }).toList();

    return _listaCategoria;
  }

}