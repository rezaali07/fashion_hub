import 'package:dartz/dartz.dart';
import 'package:fashion_hub/app/usecase/usecase.dart';
import 'package:fashion_hub/core/error/failure.dart';
import 'package:fashion_hub/features/auth/domain/entity/user_entity.dart';
import 'package:fashion_hub/features/auth/domain/repository/user_repository.dart';

class GetAllUserUsecase implements UsecaseWithoutParams {
  final IUserRepository userRepository;
  const GetAllUserUsecase({required this.userRepository});
  @override
  Future<Either<Failure, List<UserEntity>>> call() {
    return userRepository.getAllUsers();
  }
}
