import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fashion_hub/app/usecase/usecase.dart';
import 'package:fashion_hub/core/error/failure.dart';
import 'package:fashion_hub/features/auth/domain/repository/user_repository.dart';

class UploadImageParams {
  final File file;

  const UploadImageParams({
    required this.file,
  });
}

class UploadImageUseCase
    implements UsecaseWithParams<String, UploadImageParams> {
  final IUserRepository _repository;

  UploadImageUseCase(this._repository);

  @override
  Future<Either<Failure, String>> call(UploadImageParams params) {
    return _repository.uploadImage(params.file);
  }
}
