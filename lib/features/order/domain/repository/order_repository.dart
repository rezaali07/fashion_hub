import 'package:dartz/dartz.dart';
import 'package:fashion_hub/features/Order/domain/entity/order_entity.dart';
import 'package:fashion_hub/core/error/failure.dart';

abstract interface class IOrderRepository {
  Future<Either<Failure, List<OrderEntity>>> getOrder();
  Future<Either<Failure, void>> createOrder(OrderEntity order);
  Future<Either<Failure, void>> deleteOrder(String id);
}
