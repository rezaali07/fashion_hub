import 'package:dartz/dartz.dart';
import 'package:fashion_hub/app/usecase/usecase.dart';
import 'package:fashion_hub/core/error/failure.dart';
import 'package:fashion_hub/features/order/domain/entity/order_entity.dart';
import 'package:fashion_hub/features/order/domain/repository/order_repository.dart';

class GetAllOrderUsecase implements UsecaseWithoutParams<List<OrderEntity>> {
  final IOrderRepository _orderRepository;

  GetAllOrderUsecase({required IOrderRepository orderRepository})
      : _orderRepository = orderRepository;

  @override
  Future<Either<Failure, List<OrderEntity>>> call() {
    return _orderRepository.getOrder();
  }

  // @override
  // Future<Either<Failure, List<OrderEntity>>> call() {
  //   return _orderRepository.getOrder();
  // }
}
