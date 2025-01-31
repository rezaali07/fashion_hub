import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fashion_hub/app/usecase/usecase.dart';
import 'package:fashion_hub/core/error/failure.dart';
import 'package:fashion_hub/features/auth/domain/repository/user_repository.dart';

class DeleteUserParams extends Equatable {
  final String userId;

  const DeleteUserParams({required this.userId});

  const DeleteUserParams.empty() : userId = "_empty.string";

  @override
  List<Object?> get props => [userId];
}

class DeleteUserUsecase implements UsecaseWithParams<void, DeleteUserParams> {
  final IUserRepository userRepository;

  const DeleteUserUsecase({required this.userRepository});

  @override
  Future<Either<Failure, void>> call(DeleteUserParams params) async {
    return await userRepository.deleteUser(params.userId);
  }
}