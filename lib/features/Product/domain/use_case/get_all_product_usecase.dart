// // import 'package:dartz/dartz.dart';
// // import 'package:fashion_hub/app/shared_prefs/token_shared_prefs.dart';
// // import 'package:fashion_hub/app/usecase/usecase.dart';
// // import 'package:fashion_hub/core/error/failure.dart';
// // import 'package:fashion_hub/features/Product/domain/entity/product_entity.dart';
// // import 'package:fashion_hub/features/Product/domain/repository/product_repository.dart';

// // class GetAllProductUseCase
// //     implements UsecaseWithoutParams<List<ProductEntity>> {
// //   final IProductRepository productRepository;
// //   final TokenSharedPrefs tokenSharedPrefs;

// //   GetAllProductUseCase({
// //     required this.productRepository,
// //     required this.tokenSharedPrefs,
// //   });

// //   @override
// //   Future<Either<Failure, List<ProductEntity>>> call() async {
// //     try {
// //       //  Get token
// //       final token = await tokenSharedPrefs.getToken();

// //       // Handle token retrieval failure or empty token
// //       return token.fold(
// //         (failure) => Left(
// //             failure), // If there's a failure getting the token, return that failure
// //         (token) async {
// //           if (token.isEmpty) {
// //             return const Left(
// //                 SharedPrefsFailure(message: 'No token available'));
// //           }

// //           return await productRepository
// //               .getProduct(token); // Pass the token to the repository
// //         },
// //       );
// //     } catch (e) {
// //       // If an unexpected error occurs, return it as a failure
// //       return Left(
// //         SharedPrefsFailure(
// //             message: 'Unexpected error occurred: ${e.toString()}'),
// //       );
// //     }
// //   }
// // }

import 'package:dartz/dartz.dart';
import 'package:fashion_hub/app/shared_prefs/token_shared_prefs.dart';
import 'package:fashion_hub/core/error/failure.dart';
import 'package:fashion_hub/features/Product/domain/entity/product_entity.dart';
import 'package:fashion_hub/features/Product/domain/repository/product_repository.dart';

class GetAllProductUseCase {
  final IProductRepository productRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  GetAllProductUseCase({
    required this.productRepository,
    required this.tokenSharedPrefs,
  });
 
  Future<Either<Failure, List<ProductEntity>>> call() async {
    try {
      print("🔹 Fetching token...");
      final tokenResult = await tokenSharedPrefs.getToken();

      return tokenResult.fold(
        (failure) {
          print("❌ Token Fetch Failure: ${failure.message}");
          return Left(failure);
        },
        (token) async {
          if (token.isEmpty) {
            print("❌ No token found!");
            return const Left(SharedPrefsFailure(message: 'No token available'));
          }

          print("✅ Token Retrieved: $token");
          final result = await productRepository.getProduct(token);

          result.fold(
            (failure) => print("❌ API Failure: ${failure.message}"),
            (products) => print("✅ Fetched Products: ${products.length}"),
          );

          return result;
        },
      );
    } catch (e) {
      print("❌ Unexpected Error: $e");
      return Left(SharedPrefsFailure(message: 'Unexpected error: ${e.toString()}'));
    }
  }
}
