import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fashion_hub/app/shared_prefs/token_shared_prefs.dart';
import 'package:fashion_hub/app/usecase/usecase.dart';
import 'package:fashion_hub/core/error/failure.dart';
import 'package:fashion_hub/features/auth/domain/repository/user_repository.dart';

class LoginUserParams extends Equatable {
  final String email;
  final String password;

  const LoginUserParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}

class LoginUserUsecase
    implements UsecaseWithParams<String, LoginUserParams> {
  final IUserRepository userRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  const LoginUserUsecase(
      {required this.tokenSharedPrefs, required this.userRepository});

  @override
  Future<Either<Failure, String>> call(LoginUserParams params) async {
    //Save token in Shared Preferences
    return userRepository
        .login(params.email, params.password)
        .then((value) {
      return value.fold(
        (failure) => Left(failure),
        (token) {
          tokenSharedPrefs.saveToken(token);
          tokenSharedPrefs.getToken().then((value) {
            print(value);
          });
          return Right(token);
        },
      );
    });

    // try {
    //   // Call login function from the repository
    //   final result =
    //       await userRepository.login(params.username, params.password);
    //
    //   return result.fold(
    //     (failure) {
    //       // On failure, return the failure response (including status code and message)
    //       return Left(ApiFailure(
    //         message: failure.message,
    //         statusCode: failure.statusCode ??
    //             500, // Set default statusCode as 500 if null
    //       ));
    //     },
    //     (_) {
    //       // On success, return success with no data (void)
    //       return const Right(null);
    //     },
    //   );
    // } catch (e) {
    //   // In case of any unexpected error, we handle it here
    //   return Left(ApiFailure(
    //     message: 'An unexpected error occurred: $e',
    //     statusCode: 500, // Default status code for unhandled exceptions
    //   ));
    // }
  }
}
