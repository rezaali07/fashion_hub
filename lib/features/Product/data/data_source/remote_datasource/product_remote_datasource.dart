import 'package:dio/dio.dart';
import 'package:fashion_hub/app/constants/api_endpoints.dart';
import 'package:fashion_hub/features/Product/data/data_source/product_data_source.dart';
import 'package:fashion_hub/features/Product/data/dto/get_all_product_dto.dart';
import 'package:fashion_hub/features/Product/data/model/product_api_model.dart';
import 'package:fashion_hub/features/Product/domain/entity/product_entity.dart';

class ProductRemoteDataSource implements IProductDataSource {
  final Dio _dio;
  ProductRemoteDataSource(this._dio);

  @override
  Future<void> createProduct(ProductEntity product) async {
    try {
      // Convert entity into model
      var productApiModel = ProductApiModel(
        id: product.id,
        name: product.name,
        category: product.category,
        imageUrl: product.imageUrl,
        price: product.price,
      );
      
      var response = await _dio.post(
        ApiEndpoints.createProduct,
        data: productApiModel.toJson(),
      );
      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ProductEntity>> getProduct(String? token) async {
    if (token == null || token.isEmpty) {
      throw Exception("Access denied: No token provided");
    }

    try {
      var response = await _dio.get(
        ApiEndpoints.getAllProduct,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      GetAllProductDTO productDTO = GetAllProductDTO.fromJson(response.data);
      List<ProductApiModel> productModels = List<ProductApiModel>.from(
        productDTO.products.map((product) => ProductApiModel.fromJson(product as Map<String, dynamic>))
      );
      return ProductApiModel.toEntityList(productModels); // Converting to entities
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteProduct(String id, String? token) async {
    try {
      var response = await _dio.delete(
        ApiEndpoints.deleteProduct + id,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
