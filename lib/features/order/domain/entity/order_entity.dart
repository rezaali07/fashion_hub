import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final String? orderId;
  final String? productId;
  final String date;
  final String time;
  final String status;

  const OrderEntity({
    this.productId,
    this.orderId,
    required this.date,
    required this.status,
    required this.time,
  });

  @override
  List<Object?> get props => [orderId, productId, date, time, status];
}
