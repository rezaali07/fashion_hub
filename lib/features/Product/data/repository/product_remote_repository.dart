import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fashion_hub/core/error/failure.dart';
import 'package:fashion_hub/features/Product/data/data_source/remote_datasource/product_remote_datasource.dart';
import 'package:fashion_hub/features/Product/domain/entity/product_entity.dart';
import 'package:fashion_hub/features/Product/domain/repository/product_repository.dart';

class ProductRemoteRepository implements IProductRepository {
  final ProductRemoteDataSource _productRemoteDatasource;
  ProductRemoteRepository(this._productRemoteDatasource);

  @override
  Future<Either<Failure, void>> createProduct(ProductEntity product) async {
    try {
      _productRemoteDatasource.createProduct(product);
      return const Right(null);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id, String? token) async {
    try {
      _productRemoteDatasource.deleteProduct(id, token);
      return const Right(null);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProduct(String? token) async {
    try {
      final product = await _productRemoteDatasource.getProduct(token);
      return Right(product);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> uploadProductPicture(File file) {
    // TODO: implement uploadProductPicture
    throw UnimplementedError();
  }
}
