import 'package:dartz/dartz.dart';
import 'package:fashion_hub/core/error/failure.dart';
import 'package:fashion_hub/features/auth/domain/entity/user_entity.dart';
import 'package:fashion_hub/features/auth/domain/use_case/get_all_user_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


import 'auth_repo.mock.dart';
import 'token.mock.dart';

void main() {
  late AuthRepoMock repository;
  late MockTokenSharedPrefs sharedPrefs;
  late GetAllUserUsecase usecase;

  setUp(() {
    repository = AuthRepoMock();
    sharedPrefs = MockTokenSharedPrefs();
    usecase = GetAllUserUsecase(
      userRepository: repository,
      // tokenSharedPrefs: sharedPrefs,
    );

    // registerFallbackValue(const GetAllUserUsecase(token: ''));
  });

  final tUser1 = UserEntity(
    
    name: 'Test User 1',
    email: 'test user 1',
    password: 'test@12345'
  );

  final tUser2 = UserEntity(
   
    name: 'Test User 2',
    email: 'testuser2@email.com',
    password: 'test@123456'
  );

  final List<UserEntity> tUsers = [tUser1, tUser2];
  final token = 'valid_token';

  group('GetAllUserUsecase Tests', () {
    test('should call repository.getAllUsers with provided token', () async {
      // Arrange
      when(() => repository.getAllUsers()).thenAnswer(
        (_) async => Right<Failure, List<UserEntity>>(tUsers),
      );

      // Act
      // final result =
          // await usecase(const GetAllUserUsecase(token: "valid_token"));

      // Assert
      // expect(result, Right<Failure, List<UserEntity>>(tUsers));
      // verify(() => repository.getAllUsers(token)).called(1);
      // verifyNever(() => sharedPrefs.getToken());
    });

    test('should fetch token from sharedPrefs if no token is provided',
        () async {
      // Arrange
      when(() => sharedPrefs.getToken()).thenAnswer(
        (_) async => Right<Failure, String>(token),
      );
      // when(() => repository.getAllUsers(token)).thenAnswer(
        // (_) async => Right<Failure, List<UserEntity>>(tUsers),
      // );

      // Act
      // final result = await usecase(const GetAllUserUsecase.empty());

      // Assert
      // expect(result, Right<Failure, List<UserEntity>>(tUsers));
      verify(() => sharedPrefs.getToken()).called(1);
      // verify(() => repository.getAllUsers(token)).called(1);
    });

    test('should return failure if token is not available', () async {
      // Arrange
      when(() => sharedPrefs.getToken()).thenAnswer(
        (_) async =>
            Left<Failure, String>(ApiFailure(message: "Token not found")),
      );

      // Act
      // final result = await usecase(const GetAllUserUsecase.empty());

      // Assert
      expect(
        // result,
        isA<Left<Failure, List<UserEntity>>>().having(
            (left) => (left as Left).value,
            'failure',
            isA<ApiFailure>()
                .having((f) => f.message, 'message', "Token not found")),
      );
      verify(() => sharedPrefs.getToken()).called(1);
      verifyNever(() => repository.getAllUsers(any()));
    });

    test('should return failure if repository.getAllUsers fails', () async {
      // Arrange
      // // when(() => repository.getAllUsers(token)).thenAnswer(
      //   (_) async => Left<Failure, List<UserEntity>>(
      //       ApiFailure(message: "Server error")),
      // );

      // Act
      // final result =
          // await usecase(const GetAllUserUsecase(token: "valid_token"));

      // Assert
      expect(
        // result,
        isA<Left<Failure, List<UserEntity>>>().having(
            (left) => (left as Left).value,
            'failure',
            isA<ApiFailure>()
                .having((f) => f.message, 'message', "Server error")),
      );
      // verify(() => repository.getAllUsers(token)).called(1);
      verifyNever(() => sharedPrefs.getToken());
    });
  });
}
