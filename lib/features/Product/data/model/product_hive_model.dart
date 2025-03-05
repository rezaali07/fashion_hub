import 'package:equatable/equatable.dart';
import 'package:fashion_hub/app/constants/hive_table_constant.dart';
import 'package:fashion_hub/features/Product/domain/entity/product_entity.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

part 'product_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.productTableId)
class ProductHiveModel extends Equatable {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String? imageUrl;
  @HiveField(3)
  final String category;
  @HiveField(4)
  final num price;

  ProductHiveModel({
    String? id,
    required this.name,
    this.imageUrl,
    required this.category,
    required this.price,
  }) : id = id ?? const Uuid().v4();  // ✅ Ensures id is always generated

  // ✅ FIXED: Correct Initial Constructor
  const ProductHiveModel.initial()
      : id = '',
        name = '',
        imageUrl = '',
        category = '',
        price = 0; // ✅ Changed from '' to 0 (num)

  // ✅ Converts from Domain Entity to Hive Model
  factory ProductHiveModel.fromEntity(ProductEntity entity) {
    return ProductHiveModel(
      id: entity.id ?? const Uuid().v4(), // ✅ Ensure ID exists
      name: entity.name,
      imageUrl: entity.imageUrl,
      category: entity.category,
      price: entity.price,
    );
  }

  // ✅ Converts Hive Model to Domain Entity
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      name: name,
      imageUrl: imageUrl,
      category: category,
      price: price,
    );
  }

  @override
  List<Object?> get props => [id, name, imageUrl, category, price];
}

// ✅ Converts a List of Entities to Hive Models
List<ProductHiveModel> fromEntityList(List<ProductEntity> entityList) {
  return entityList.map(ProductHiveModel.fromEntity).toList();
}

// ✅ Converts a List of Hive Models to Entities
List<ProductEntity> toEntityList(List<ProductHiveModel> hiveList) {
  return hiveList.map((hive) => hive.toEntity()).toList();
}
