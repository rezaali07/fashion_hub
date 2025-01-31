import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fashion_hub/core/error/failure.dart';
import 'package:fashion_hub/features/auth/data/data_source/remote_datasource/user_remote_data_source.dart';
import 'package:fashion_hub/features/auth/domain/entity/user_entity.dart';
import 'package:fashion_hub/features/auth/domain/repository/user_repository.dart';

class UserRemoteRepository implements IUserRepository {
  final UserRemoteDataSource _userRemoteDataSource;

  UserRemoteRepository(this._userRemoteDataSource);

  @override
  Future<Either<Failure, void>> createUser(
      UserEntity userEntity) async {
    try {
      await _userRemoteDataSource.createUser(userEntity);
      return const Right(null);
    } catch (e) {
      return Left(
        ApiFailure(
          message: 'Error creating user: $e',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsers() async {
    try {
      final users = await _userRemoteDataSource.getAllUsers();
      return Right(users);
    } catch (e) {
      return Left(
        LocalDatabaseFailure(
          message: 'Error getting all users: $e',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser(String id) async {
    try {
      await _userRemoteDataSource.deleteUser(id);
      return const Right(null);
    } catch (e) {
      return Left(
        ApiFailure(
          message: 'Error deleting user: $e',
        ),
      );
    }
  }

  @override
  // Future<Either<Failure, UserEntity>> login(
  Future<Either<Failure, String>> login(
      String email, String password) async {
    try {
      final token = await _userRemoteDataSource.login(email, password);

      // // Call the login function and get the LoginResponseEntity
      // final loginResponse =
      //     await _userRemoteDataSource.login(username, password);
      //
      // // Extract the UserEntity from the LoginResponseEntity
      // final user = loginResponse.user;
      //
      // // Return the UserEntity as a Right value
      // return Right(user);
      return Right(token);
    } catch (e) {
      // Handle any errors and return the failure message
      return Left(
        LocalDatabaseFailure(
          message: 'Login failed: $e',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> uploadImage(File file) async {
    try {
      return Right(await _userRemoteDataSource.uploadImage(file));
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
