import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fashion_hub/features/auth/domain/use_case/create_user_usecase.dart';
import 'package:fashion_hub/features/auth/domain/use_case/upload_image_usecase.dart';


part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final CreateUserUsecase _createUserUsecase;
  final UploadImageUseCase _uploadImageUseCase;

  RegisterBloc({
   
    required CreateUserUsecase createUserUsecase,
    required UploadImageUseCase uploadImageUseCase,
  })  : 
        _createUserUsecase = createUserUsecase,
        _uploadImageUseCase = uploadImageUseCase,
        super(RegisterState.initial()) {
    on<RegisterUser>(_onRegisterUser);
    on<LoadImage>(_onLoadImage);

  }

  void _onLoadImage(
    LoadImage event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isImageLoading: true));
    final result = await _uploadImageUseCase.call(
      UploadImageParams(
        file: event.file,
      ),
    );

    result.fold(
        (l) =>
            emit(state.copyWith(isImageLoading: false, isImageSuccess: false)),
        (r) {
      emit(state.copyWith(
          isImageLoading: false, isImageSuccess: true, imageName: r));
    });
  }


  Future<void> _onRegisterUser(
      RegisterUser event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(isLoading: true));

    final params = CreateUserParams(
      name: event.name,
      email: event.email,
      password: event.password,
      image: state.imageName,
    );

    print('Registering User with params: ${params.toJson()}');

    final result = await _createUserUsecase.call(params);

    print(result);

    // (user) => emit(state.copyWith(isLoading: false, isSuccess: true));

    result.fold(
        (failure) => emit(state.copyWith(isLoading: false, isSuccess: false)),
        (user) => emit(state.copyWith(isLoading: false, isSuccess: true)));
  }
}
