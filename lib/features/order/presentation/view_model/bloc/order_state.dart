part of 'order_bloc.dart';

class OrderState extends Equatable {
  final bool isLoading;
  final List<OrderEntity> order;
  final String error;

  const OrderState({
    required this.isLoading,
    required this.order,
    required this.error,
  });

  factory OrderState.initial() {
    return const OrderState(
      isLoading: false,
      order: [],
      error: '',
    );
  }

  OrderState copyWith({
    bool? isLoading,
    List<OrderEntity>? order,
    String? error,
  }) {
    return OrderState(
      isLoading: isLoading ?? this.isLoading,
      order: order ?? this.order,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [isLoading, order, error];
}
