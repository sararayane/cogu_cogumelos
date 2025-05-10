import 'package:json_annotation/json_annotation.dart';

part 'modelo_produto.g.dart';

@JsonSerializable()
class Product {
  final int? id;
  final String name;
  final String category;
  final int quantity;
  final double price;
  final String desc;

  Product({
    this.id,
    required this.name,
    required this.category,
    required this.quantity,
    required this.price,
    required this.desc,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);

  /// CopyWith para permitir `prod.copyWith(...)`
  Product copyWith({
    int? id,
    String? name,
    String? category,
    int? quantity,
    double? price,
    String? desc,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      desc: desc ?? this.desc,
    );
  }
}
