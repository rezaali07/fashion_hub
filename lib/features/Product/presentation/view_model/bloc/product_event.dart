part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class GetAllProduct extends ProductEvent {
  
}

class LoadProductImage extends ProductEvent {
  final File file;

  const LoadProductImage({
    required this.file,
  });
}


final class DeleteProduct extends ProductEvent {
  final String id;

  const DeleteProduct(this.id);

  @override
  List<Object> get props => [id];
}
