part of 'modelo_fornecedores.dart';

Fornecedor _$FornecedorFromJson(Map<String, dynamic> json) => Fornecedor(
  id: json['id'] as int?,
  name: json['name'] as String,
  product: json['product'] as String,
  desc: json['desc'] as String,
);

Map<String, dynamic> _$FornecedorToJson(Fornecedor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'product': instance.product,
      'desc': instance.desc,
    };
