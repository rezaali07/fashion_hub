import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fashion_hub/core/error/failure.dart';
import 'package:fashion_hub/features/Product/data/data_source/product_local_datasource/product_local_data_source.dart';
import 'package:fashion_hub/features/Product/domain/entity/product_entity.dart';
import 'package:fashion_hub/features/Product/domain/repository/product_repository.dart';

class ProductLocalRepository implements IProductRepository {
  final ProductLocalDataSource _productLocalDataSource;

  ProductLocalRepository(
      {required ProductLocalDataSource productLocalDataSource})
      : _productLocalDataSource = productLocalDataSource;

  @override
  Future<Either<Failure, void>> createProduct(ProductEntity product) {
    try {
      _productLocalDataSource.createProduct(product);
      return Future.value(const Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id, String? token) {
    try {
      _productLocalDataSource.deleteProduct(id, token);
      return Future.value(const Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProduct(String? token) {
    try {
      return _productLocalDataSource.getProduct(token).then(
        (value) {
          return Right(value);
        },
      );
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProductPicture(File file) {
    // TODO: implement uploadProductPicture
    throw UnimplementedError();
  }
}
