import 'package:json_annotation/json_annotation.dart';

part 'modelo_fornecedores.g.dart';

@JsonSerializable()
class Fornecedor {
  final int? id;
  final String name;
  final String product;
  final String desc;

  Fornecedor({
    this.id,
    required this.name,
    required this.product,
    required this.desc,
  });

  factory Fornecedor.fromJson(Map<String, dynamic> json) =>
      _$FornecedorFromJson(json);

  Map<String, dynamic> toJson() => _$FornecedorToJson(this);
}
