import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fashion_hub/features/Product/domain/entity/product_entity.dart';
import 'package:fashion_hub/features/Product/domain/use_case/delete_product_usecase.dart';
import 'package:fashion_hub/features/Product/domain/use_case/get_all_product_usecase.dart';
import 'package:fashion_hub/features/Product/domain/use_case/upload_image_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProductUseCase _getAllProductUseCase;
  final DeleteProductUsecase _deleteProductUsecase;
  final UploadProductImageUsecase _uploadProductImageUsecase;

  ProductBloc({
    required GetAllProductUseCase getAllProductUseCase,
    required DeleteProductUsecase deleteProductUsecase,
    required UploadProductImageUsecase uploadProductImageUsecase,
  })  : _getAllProductUseCase = getAllProductUseCase,
        _deleteProductUsecase = deleteProductUsecase,
        _uploadProductImageUsecase = uploadProductImageUsecase,
        super(ProductState.initial()) {
    on<GetAllProduct>(_onGetAllProduct);
    on<DeleteProduct>(_onDeleteProduct);
    on<LoadProductImage>(_onLoadProductImage);
  }

Future<void> _onGetAllProduct(
    GetAllProduct event, Emitter<ProductState> emit) async {
  emit(state.copyWith(isLoading: true, error: null));

  print("🔹 Fetching all products...");
  final result = await _getAllProductUseCase.call();

  result.fold(
    (failure) {
      print("❌ Error: ${failure.message}");
      emit(state.copyWith(isLoading: false, error: failure.message));
    },
    (products) {
      print("✅ Products fetched: ${products.length}");
      emit(state.copyWith(isLoading: false, product: products));
    },
  );
}


  Future<void> _onDeleteProduct(
      DeleteProduct event, Emitter<ProductState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _deleteProductUsecase
        .call(DeleteProductParams(productId: event.id));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) {
        emit(state.copyWith(isLoading: false, error: null));
        add(GetAllProduct()); // Refresh product list after deletion
      },
    );
  }

  Future<void> _onLoadProductImage(
    LoadProductImage event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _uploadProductImageUsecase.call(
      UploadProductImageParams(file: event.file),
    );
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (imageName) {
        emit(state.copyWith(
          isLoading: false,
          error: null,
          imageUrl: imageName, // Consider renaming for consistency
        ));
      },
    );
  }
}
