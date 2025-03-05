import 'package:equatable/equatable.dart';
import 'package:fashion_hub/app/constants/hive_table_constant.dart';
import 'package:fashion_hub/features/order/domain/entity/order_entity.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

part 'order_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.orderTableId)
class OrderHiveModel extends Equatable {
  @HiveField(0)
  final String? orderId;
  @HiveField(1)
  final String? productId;
  @HiveField(2)
  final String date;
  @HiveField(3)
  final String time;
  @HiveField(4)
  final String status;

  OrderHiveModel({
    String? orderId,
    String? productId,
    required this.time,
    required this.date,
    required this.status,
  })  : orderId = orderId ?? const Uuid().v4(),
        productId = productId ?? const Uuid().v4();

  // Initail Constructor
  const OrderHiveModel.initial()
      : orderId = '',
        productId = '',
        date = '',
        time = '',
        status = '';

  // From Entity
  factory OrderHiveModel.fromEntity(OrderEntity entity) {
    return OrderHiveModel(
      orderId: entity.orderId,
      productId: entity.productId,
      date: entity.date,
      time: entity.time,
      status: entity.status,
    );
  }

  // To Entity
  OrderEntity toEntity() {
    return OrderEntity(
      orderId: orderId,
      productId: productId,
      date: date,
      time: time,
      status: status,
    );
  }

  @override
  List<Object?> get props => [orderId, productId, date, time, status];
}

// From Entity List
List<OrderHiveModel> fromEntityList(List<OrderEntity> entityList) {
  return entityList.map((entity) => OrderHiveModel.fromEntity(entity)).toList();
}

// To Entity List
List<OrderEntity> toEntityList(List<OrderHiveModel> hiveList) {
  return hiveList.map((hive) => hive.toEntity()).toList();
}
