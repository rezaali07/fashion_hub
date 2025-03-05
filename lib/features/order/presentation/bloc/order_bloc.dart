import 'package:fashion_hub/features/order/domain/entities/order_entity.dart';
import 'package:fashion_hub/features/order/domain/repositories/order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Event
abstract class OrderEvent {}

class PlaceOrderEvent extends OrderEvent {
  final OrderEntity order;
  final String token;

  PlaceOrderEvent(this.order, this.token);
}

// State
abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {}

class OrderFailure extends OrderState {
  final String error;

  OrderFailure(this.error);
}

// Bloc
class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository repository;

  OrderBloc(this.repository) : super(OrderInitial()) {
    on<PlaceOrderEvent>((event, emit) async {
      emit(OrderLoading());
      try {
        // Pass the token along with the order to the repository
        await repository.placeOrder(event.order, event.token);
        emit(OrderSuccess());
      } catch (e) {
        emit(OrderFailure(e.toString()));
      }
    });
  }
}
