import 'dart:convert';

import 'package:cardapio_mobile/models/produto.dart';
import 'package:http/http.dart' as http;

class ProdutoService {

  static Future<List<Produto>> getAll({required int categoriaId}) async {

    late List<Produto> _listaProdutos = [];
    final response = await http.get(Uri.parse("https://www.glix.web.br.com/flutter/cardapio/phps/listaProdutos.php?categoria=$categoriaId"));
    final items = json.decode(response.body).cast<Map<String, dynamic>>();

    _listaProdutos = items.map<Produto>((json) {
      return Produto.fromJson(json);
    }).toList();

    return _listaProdutos;
  }

}