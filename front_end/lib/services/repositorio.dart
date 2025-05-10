import 'package:cogu_cogumelo/models/modelo_fornecedores.dart';
import 'package:cogu_cogumelo/models/modelo_produto.dart';
import 'api_service.dart';

class Repository {
  Repository._();
  static final instance = Repository._();

  Future<List<Product>> fetchProducts() => ApiService.fetchProducts();
  Future<void> addProduct(Product p) => ApiService.addProduct(p);
  Future<void> updateStock(String nome, String op, int qt) =>
      ApiService.updateStock(nome, op, qt);

  Future<List<Fornecedor>> fetchSuppliers() => ApiService.fetchSuppliers();
  Future<void> addSupplier(Fornecedor s) => ApiService.addSupplier(s);
}
