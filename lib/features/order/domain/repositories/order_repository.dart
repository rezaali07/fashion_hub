import 'dart:async';

import 'package:fashion_hub/features/order/data/remote/order_remote_data_source.dart';
import 'package:fashion_hub/features/order/domain/entities/order_entity.dart';

class OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepository(this.remoteDataSource);

  Future<void> placeOrder(OrderEntity order, String token) async {
    try {
      // Pass the token along with the order to the remote data source
      await remoteDataSource.placeOrder(order.toJson(), token);
    } catch (e) {
      // Translate or handle exceptions if needed
      throw Exception("Error placing the order: ${e.toString()}");
    }
  }
}
