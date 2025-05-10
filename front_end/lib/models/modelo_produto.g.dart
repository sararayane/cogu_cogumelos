part of 'modelo_produto.dart';

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  id: json['id'] as int?,
  name: json['name'] as String,
  category: json['category'] as String,
  quantity: json['quantity'] as int,
  price: (json['price'] as num).toDouble(),
  desc: json['desc'] as String,
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'category': instance.category,
  'quantity': instance.quantity,
  'price': instance.price,
  'desc': instance.desc,
};
