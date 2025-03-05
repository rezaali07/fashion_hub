import 'package:dio/dio.dart';
import 'package:fashion_hub/app/constants/api_endpoints.dart';
import 'package:fashion_hub/features/Product/data/model/product_api_model.dart';
import 'package:fashion_hub/features/Product/domain/entity/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_product_dto.g.dart';

@JsonSerializable()
class GetAllProductDTO {
  final bool success;
  final int productsCount;
  final List<Map<String, dynamic>> products;
  

  Map<String, dynamic> toJson() => _$GetAllProductDTOToJson(this);

  factory GetAllProductDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllProductDTOFromJson(json);

  GetAllProductDTO({required this.success, required this.productsCount, required this.products});

  // Static method to fetch products and return a list of ProductEntity
  static Future<List<ProductEntity>> getProducts(String? token) async {
    if (token == null || token.isEmpty) {
      throw Exception("Access denied: No token provided");
    }

    try {
      var dio = Dio();  // Initialize Dio instance here
      var response = await dio.get(
        ApiEndpoints.getAllProduct,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      // Deserialize the response to GetAllProductDTO
      GetAllProductDTO productDTO = GetAllProductDTO.fromJson(response.data);

      // Convert raw JSON data to ProductApiModel
      List<ProductApiModel> productModels = productDTO.products
          .map((productJson) => ProductApiModel.fromJson(productJson))
          .toList();

      // Convert ProductApiModel list to ProductEntity list
      return ProductApiModel.toEntityList(productModels);
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
