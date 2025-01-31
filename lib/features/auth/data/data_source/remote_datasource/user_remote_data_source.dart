import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fashion_hub/app/constants/api_endpoints.dart';
import 'package:fashion_hub/features/auth/data/model/user_api_model.dart';
import 'package:fashion_hub/features/auth/domain/entity/user_entity.dart';

class UserRemoteDataSource {
  final Dio _dio;

  UserRemoteDataSource(this._dio);

  /// Creates a new user
  Future<void> createUser(UserEntity userEntity) async {
    try {
      // Convert entity to model
      var userApiModel = UserApiModel.fromEntity(userEntity);
      var response = await _dio.post(
        ApiEndpoints.createUser,
        data: userApiModel.toJson(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Deletes a user by ID
  Future<void> deleteUser(String userId) async {
    try {
      var response = await _dio.delete(
        '${ApiEndpoints.deleteUser}/$userId',
      );
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Gets all users
  Future<List<UserEntity>> getAllUsers() async {
    try {
      var response = await _dio.get(ApiEndpoints.getAllUsers);
      if (response.statusCode == 200) {
        var data = response.data as List<dynamic>;
        return data
            .map((user) => UserApiModel.fromJson(user).toEntity())
            .toList();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Logs in a user
  Future<String> login(String email, String password) async {
    try {
      var response = await _dio.post(
        ApiEndpoints.loginUser,
        data: {
          'email': email,
          'password': password,
        },
      );

      print('Response Data: ${response.data}');

      // Check if response is not null and has statusCode 200
      if (response.statusCode == 200 && response.data != null) {
        var responseData = response.data;

        // Ensure the response contains necessary data, including 'token'
        final tokenStr = responseData['token'];

        if (tokenStr != null) {
          return tokenStr;

          // Safely handle nullable fields
          // return LoginResponseEntity(
          //   user: UserEntity(
          //     email: '',
          //     phone: '',
          //     password: '',
          //     fname: '',
          //     lname: '',
          //     batch: const BatchEntity(batchName: ''),
          //     courses: [],
          //   ),
          //   token: token,
          // );
        } else {
          throw Exception('Response does not contain valid token');
        }
      } else {
        throw Exception('Invalid response: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Dio Error: ${e.message ?? 'Unknown error'}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  @override
  Future<String> uploadImage(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "profilePicture":
            await MultipartFile.fromFile(file.path, filename: fileName)
      });

      Response response =
          await _dio.post(ApiEndpoints.uploadImage, data: formData);

      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception('Network error during profile upload: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
