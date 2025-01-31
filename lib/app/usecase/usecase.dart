import 'package:dartz/dartz.dart';
import 'package:fashion_hub/core/error/failure.dart';

// Generic class to use with Parameters
abstract interface class UsecaseWithParams<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

// Generic class to use without Parameters
abstract interface class UsecaseWithoutParams<SuccessType> {
  Future<Either<Failure, SuccessType>> call();
}
