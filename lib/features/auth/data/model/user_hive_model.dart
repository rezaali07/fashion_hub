import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fashion_hub/app/constants/hive_table_constant.dart';
import 'package:fashion_hub/features/auth/domain/entity/user_entity.dart';

import 'package:uuid/uuid.dart';

part 'user_hive_model.g.dart';
//dart run build_runner build -d

@HiveType(typeId: HiveTableConstant.userTableId)
class UserHiveModel extends Equatable {
  @HiveField(0)
  final String? userId;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? image;

  @HiveField(3)
  final String email;

  @HiveField(4)
  final String password;

  UserHiveModel({
    String? userId,
    required this.name,
    
    this.image,
    required this.email,
    required this.password,
  }) : userId = userId ?? const Uuid().v4();

  /// Initial constructor
  const UserHiveModel.initial()
      : userId = '',
        name = '',
        image = '',
        email = '',
        password = '';

  // Convert from entity
  factory UserHiveModel.fromEntity(UserEntity entity) {
    return UserHiveModel(
      userId: entity.userId,
      name: entity.name,
      image: entity.image,
      email: entity.email,
      password: entity.password,
    );
  }

  // Convert to entity
  UserEntity toEntity() {
    return UserEntity(
      userId: userId,
      name: name,
      image: image,
      email: email,
      password: password,
    );
  }

  static List<UserHiveModel> fromEntityList(List<UserEntity> entityList) {
    return entityList
        .map((entity) => UserHiveModel.fromEntity(entity))
        .toList();
  }

  @override
  List<Object?> get props => [
        userId,
        name,
        image,
        email,
        password,
      ];
}
