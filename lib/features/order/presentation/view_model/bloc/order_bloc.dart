import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fashion_hub/features/Order/domain/use_case/create_order_usecase.dart';
import 'package:fashion_hub/features/Order/domain/use_case/delete_order_usecase.dart';
import 'package:fashion_hub/features/Order/domain/use_case/get_all_order_usecase.dart';
import 'package:fashion_hub/features/Order/domain/entity/order_entity.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetAllOrderUsecase _getAllOrderUsecase;
  final CreateOrderUsecase _createOrderUsecase;
  final DeleteOrderUsecase _deleteOrderUsecase;
  OrderBloc({
    required GetAllOrderUsecase getAllOrderUsecase,
    required CreateOrderUsecase createOrderUsecase,
    required DeleteOrderUsecase deleteOrderUsecase,
  })  : _getAllOrderUsecase = getAllOrderUsecase,
        _createOrderUsecase = createOrderUsecase,
        _deleteOrderUsecase = deleteOrderUsecase,
        super(OrderState.initial()) {
    on<OrderLoad>(_onOrderLoad);
    on<CreateOrder>(_onCreateOrder);
    on<DeleteOrder>(_onDeleteOrder);

    add(OrderLoad());
  }

  Future<void> _onOrderLoad(
    OrderLoad event,
    Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllOrderUsecase();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (order) => emit(state.copyWith(isLoading: false, order: order)),
    );
  }

  Future<void> _onCreateOrder(
    CreateOrder event,
    Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _createOrderUsecase(CreateOrderParams(
        date: event.date, time: event.time, status: event.status));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) {
        emit(state.copyWith(isLoading: false));
        add(OrderLoad());
      },
    );
  }

  Future<void> _onDeleteOrder(
    DeleteOrder event,
    Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _deleteOrderUsecase(DeleteOrderParams(id: event.id));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) {
        emit(state.copyWith(isLoading: false));
        add(OrderLoad());
      },
    );
  }
}
