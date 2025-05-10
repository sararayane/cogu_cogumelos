import 'dart:convert';
import 'package:cogu_cogumelo/models/modelo_fornecedores.dart';
import 'package:cogu_cogumelo/models/modelo_produto.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const _base = String.fromEnvironment(
    'API_URL',
    defaultValue: 'http://localhost:5000',
  );

  // PRODUTOS
  static Future<List<Product>> fetchProducts() async {
    final res = await http.get(Uri.parse('$_base/produtos'));
    if (res.statusCode != 200) {
      throw Exception('Erro ao buscar produtos (${res.statusCode})');
    }
    final data = jsonDecode(res.body) as List<dynamic>;
    return data
        .map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static Future<void> addProduct(Product p) async {
    final res = await http.post(
      Uri.parse('$_base/produtos'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(p.toJson()),
    );
    if (res.statusCode != 201 && res.statusCode != 200) {
      throw Exception('Erro ao adicionar produto (${res.statusCode})');
    }
  }

  static Future<void> updateStock(String nome, String operacao, int qt) async {
    final res = await http.put(
      Uri.parse('$_base/produtos/estoque'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nome_produto': nome,
        'operacao': operacao,
        'quantidade': qt,
      }),
    );
    if (res.statusCode != 200) {
      throw Exception('Erro ao atualizar estoque (${res.statusCode})');
    }
  }

  // FORNECEDORES
  static Future<List<Fornecedor>> fetchSuppliers() async {
    final res = await http.get(Uri.parse('$_base/fornecedor'));
    if (res.statusCode != 200) {
      throw Exception('Erro ao buscar fornecedores (${res.statusCode})');
    }
    final data = jsonDecode(res.body) as List<dynamic>;
    return data
        .map((e) => Fornecedor.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static Future<void> addSupplier(Fornecedor s) async {
    final res = await http.post(
      Uri.parse('$_base/fornecedor'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(s.toJson()),
    );
    if (res.statusCode != 201 && res.statusCode != 200) {
      throw Exception('Erro ao adicionar fornecedor (${res.statusCode})');
    }
  }
}
