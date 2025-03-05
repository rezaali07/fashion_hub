import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fashion_hub/app/usecase/usecase.dart';
import 'package:fashion_hub/core/error/failure.dart';
import 'package:fashion_hub/features/auth/domain/entity/user_entity.dart';
import 'package:fashion_hub/features/auth/domain/repository/user_repository.dart';

class CreateUserParams extends Equatable {
  final String name;

  final String email;
  final String password;
  final String? image;

  const CreateUserParams({
    required this.name,
    required this.email,
    required this.password,
    this.image,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        image,
      ];

  Map<String, dynamic> toJson() {
    return {
      'fName': name,
      'email': email,
      'password': password,
      'image': image,
    };
  }
}

class CreateUserUsecase implements UsecaseWithParams<void, CreateUserParams> {
  final IUserRepository userRepository;

  const CreateUserUsecase({required this.userRepository});

  @override
  Future<Either<Failure, void>> call(CreateUserParams params) async {
    // Create the User entity from the params
    final userEntity = UserEntity(
      userId: null,
      // The ID will be generated automatically
      name: params.name,
      email: params.email,
      password: params.password,
      image: params.image,
    );

    // Call the repository method to create the User
    return await userRepository.createUser(userEntity);
  }
}
