import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fashion_hub/core/error/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserIdSharedPrefs {
  final SharedPreferences _sharedPreferences;
  UserIdSharedPrefs(this._sharedPreferences);

  Future<Either<Failure, void>> saveToken(String token) async {
    try {
      await _sharedPreferences.setString('token', token);
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String>> getToken() async {
    try {
      final token = _sharedPreferences.getString('token');
      return Right(token ?? '');
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }
  // Save user ID to SharedPreferences
  Future<Either<Failure, void>> saveUserId(String userId) async {
    try {
      await _sharedPreferences.setString('userId', userId);
      print("Saved User ID: $userId"); // Debug log
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // Get user ID from SharedPreferences
  Future<Either<Failure, String>> getUserId() async {
    try {
      final userId = _sharedPreferences.getString('userId');
      if (userId == null || userId.isEmpty) {
        return const Left(SharedPrefsFailure(message: 'User ID not found.'));
      }
      print("Retrieved User ID: $userId"); // Debug log
      return Right(userId);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<bool> setUser(Map<String, dynamic> user) async {
    try {
      String userDataString = jsonEncode(user);
      await _sharedPreferences.setString('user', userDataString);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>?> getUser() async {
    try {
      String? userDataString = _sharedPreferences.getString('user');
      if (userDataString == null || userDataString.isEmpty) {
        return null;
      }
      Map<String, dynamic> userData = jsonDecode(userDataString);
      return userData;
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteUser() async {
    try {
      await _sharedPreferences.remove('user');
      return true;
    } catch (e) {
      return false;
    }
  }
}
