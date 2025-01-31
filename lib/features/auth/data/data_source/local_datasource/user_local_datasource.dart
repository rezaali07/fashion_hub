import 'package:fashion_hub/core/network/hive_service.dart';
import 'package:fashion_hub/features/auth/data/data_source/user_data_source.dart';
import 'package:fashion_hub/features/auth/data/model/user_hive_model.dart';
import 'package:fashion_hub/features/auth/domain/entity/user_entity.dart';

class UserLocalDatasource implements IUserDataSource {
  final HiveService _hiveService;

  UserLocalDatasource(this._hiveService);

  @override
  Future<void> createUser(UserEntity userEntity) async {
    try {
      final userHiveModel = UserHiveModel.fromEntity(userEntity);
      await _hiveService.addUser(userHiveModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteUser(String id) async {
    try {
      return await _hiveService.deleteUser(id);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<UserEntity>> getAllUsers() async {
    try {
      return await _hiveService.getAllUsers().then((value) {
        return value.map((e) => e.toEntity()).toList();
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> login(String username, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

// @override
// Future<UserEntity> login(String username, String password) async{
//   try {
//      final userHiveModel = await _hiveService.loginUser(username, password);
//      return userHiveModel!.toEntity();
//   } catch (e) {
//     throw Exception(e);
//   }
// }
}
