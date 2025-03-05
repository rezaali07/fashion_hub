part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class OrderLoad extends OrderEvent {}

class CreateOrder extends OrderEvent {
  final String date;
  final String time;
  final String status;

  const CreateOrder({
    required this.date,
    required this.time,
    required this.status,
  });

  @override
  List<Object> get props => [date, time, status];
}

class DeleteOrder extends OrderEvent {
  final String id;

  const DeleteOrder({required this.id});

  @override
  List<Object> get props => [id];
}
