import 'package:fashion_hub/features/order/data/model/order_api_model.dart';
import 'package:json_annotation/json_annotation.dart';


part 'get_all_order_dto.g.dart';

@JsonSerializable()
class GetAllOrderDTO {
  final bool success;
  final int count;
  final List<OrderApiModel> data;

  GetAllOrderDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllOrderDTOToJson(this);

  factory GetAllOrderDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllOrderDTOFromJson(json);
}
