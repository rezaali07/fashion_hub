part of 'product_bloc.dart';

class ProductState extends Equatable {
  final bool isLoading;
  final List<ProductEntity> product;
  final String? error;
  final String? imageUrl;

  const ProductState({
    required this.isLoading,
    required this.product,
    this.error,
    this.imageUrl,
  });

  factory ProductState.initial() {
    return const ProductState(
      isLoading: false,
      product: [],
      error: null,
      imageUrl: null,
    );
  }

  ProductState copyWith({
    bool? isLoading,
    List<ProductEntity>? product,
    String? error,
    String? imageUrl,
  }) {
    return ProductState(
      isLoading: isLoading ?? this.isLoading,
      product: product ?? this.product,
      error: error ?? this.error,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [isLoading, product, error, imageUrl];
}
