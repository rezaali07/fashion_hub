import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fashion_hub/core/error/failure.dart';
import 'package:fashion_hub/features/auth/domain/entity/user_entity.dart';

abstract interface class IUserRepository {
  Future<Either<Failure, void>> createUser(UserEntity userEntity);

  Future<Either<Failure, List<UserEntity>>> getAllUsers();

  Future<Either<Failure, void>> deleteUser(String id);

  Future<Either<Failure, String>> login(String username, String password);

  Future<Either<Failure, String>> uploadImage(File file);
}
