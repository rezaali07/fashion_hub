import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fashion_hub/core/error/failure.dart';
import 'package:fashion_hub/features/auth/data/data_source/local_datasource/user_local_datasource.dart';
import 'package:fashion_hub/features/auth/domain/entity/user_entity.dart';
import 'package:fashion_hub/features/auth/domain/repository/user_repository.dart';

class UserLocalRepository implements IUserRepository {
  final UserLocalDatasource _userLocalDataSource;

  UserLocalRepository(
      {required UserLocalDatasource userLocalDataSource})
      : _userLocalDataSource = userLocalDataSource;

  @override
  Future<Either<Failure, void>> createUser(UserEntity userEntity) {
    try {
      _userLocalDataSource.createUser(userEntity);
      return Future.value(Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser(String id) async {
    try {
      await _userLocalDataSource.deleteUser(id);
      return Right(null);
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsers() async {
    try {
      final List<UserEntity> users =
          await _userLocalDataSource.getAllUsers();
      return Right(users);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  // @override
  // Future<Either<Failure, String>> login(
  //     String email, String password) async {
  //   // try {
  //   //   final user = await _userLocalDataSource.login(email, password);
  //   //   return (Right(user));
  //   // } catch (e) {
  //   //   return Left(LocalDatabaseFailure(message: e.toString()));
  //   // }
  // }

  @override
  Future<Either<Failure, String>> uploadImage(File file) {
    // TODO: implement uploadImage
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> login(String username, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }
}
