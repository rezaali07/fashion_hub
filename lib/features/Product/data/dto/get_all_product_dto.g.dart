// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_product_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllProductDTO _$GetAllProductDTOFromJson(Map<String, dynamic> json) =>
    GetAllProductDTO(
      success: json['success'] as bool,
      productsCount: (json['productsCount'] as num).toInt(),
      products: (json['products'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$GetAllProductDTOToJson(GetAllProductDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'productsCount': instance.productsCount,
      'products': instance.products,
    };
