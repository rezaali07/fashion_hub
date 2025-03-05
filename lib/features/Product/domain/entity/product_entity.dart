import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String? id;
  final String name;
  final String? imageUrl;
  final String category;
  final num price;

  const ProductEntity({
    this.id,
    required this.name,
    this.imageUrl,
    required this.category,
    required this.price,
  });

  // from JSON
factory ProductEntity.fromJson(Map<String, dynamic> json) {
  return ProductEntity(
    id: json['_id']?.toString(),
    name: json['name']?.toString() ?? '',
    imageUrl: (json['images'] is List && json['images'].isNotEmpty) 
        ? json['images'][0]['url']?.toString() 
        : null, // ✅ Corrects `imageUrl` parsing
    category: json['category']?.toString() ?? '',
    price: (json['price'] is num) 
        ? json['price'] 
        : num.tryParse(json['price']?.toString() ?? '0') ?? 0, // ✅ Ensures safe conversion
  );
}



  // to JSON
  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'imageUrl': imageUrl,
        'category': category,
        'price': price,
      };

  @override
  List<Object?> get props => [id, name, imageUrl, category, price];
}
