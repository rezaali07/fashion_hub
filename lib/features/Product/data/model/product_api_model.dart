import 'package:equatable/equatable.dart';
import 'package:fashion_hub/features/Product/domain/entity/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_api_model.g.dart';
 
@JsonSerializable()
class ProductApiModel extends Equatable {
  @JsonKey(name: '_id') 
  final String? id;
  final String name;
  final String? imageUrl;
  final String category;
  final num price;

  const ProductApiModel({
    this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
  });

  /// ✅ **Single `fromJson` Constructor with Fixes**
  factory ProductApiModel.fromJson(Map<String, dynamic> json) {
  try {
    print("Raw JSON: $json"); // Debugging log

    json.remove("__v"); // Remove unnecessary key

    return ProductApiModel(
      id: json['_id']?.toString(),
      name: json['name']?.toString() ?? 'Unknown Product', // Default value
      imageUrl: (json['images'] is List && json['images'].isNotEmpty) 
          ? json['images'][0]['url']?.toString() 
          : 'https://via.placeholder.com/150', // Default image URL
      price: (json['price'] is num) ? json['price'] : 0, // Ensure price is not null
      category: json['category']?.toString() ?? 'Uncategorized', // Default value
    );
  } catch (e, stackTrace) {
    print("❌ Error parsing ProductApiModel: $e");
    print("📢 Raw API Response: $json");
    print("📌 Stack Trace: $stackTrace");
    rethrow;
  }
}


  Map<String, dynamic> toJson() => _$ProductApiModelToJson(this);

  // Convert to Entity
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      name: name,
      category: category,
      price: price,
      imageUrl: imageUrl ?? '',
    );
  }

  // Convert API List to Entity List
  static List<ProductEntity> toEntityList(List<ProductApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [id, name, imageUrl, category, price];
}
