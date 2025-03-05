import 'package:equatable/equatable.dart';
import 'package:fashion_hub/features/order/domain/entity/order_entity.dart';
import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class OrderApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? orderId;
  final String? productId;
  final String date;
  final String time;
  final String status;

  const OrderApiModel({
    this.orderId,
    this.productId,
    required this.date,
    required this.time,
    required this.status,
  });
  const OrderApiModel.empty()
      : orderId = '',
        productId = '',
        date = '',
        time = '',
        status = '';

  // from Json, write full code without generator
  factory OrderApiModel.fromJson(Map<String, dynamic> json) {
    return OrderApiModel(
      orderId: json['_id'],
      productId: json['_id'],
      date: json['date'],
      time: json['time'],
      status: json['status'],
    );
  }

  // Too Json, write full code without generator

  Map<String, dynamic> toJson() {
    return {
      // '_id': orderId,
      'date': date,
      'time': time,
      'status': status,
    };
  }

  // From Entity
  factory OrderApiModel.fromEntity(OrderEntity entity) {
    return OrderApiModel(
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

  // Convert Api Listy  to entity list
  static List<OrderEntity> toEntityList(List<OrderApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  // TODO: implement props
  List<Object?> get props => [orderId, productId, date, time, status];
}
