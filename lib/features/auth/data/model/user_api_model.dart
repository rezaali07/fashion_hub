import 'package:equatable/equatable.dart';
import 'package:fashion_hub/features/auth/domain/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserApiModel extends Equatable {
  @JsonKey(name: '_id') // Binding for server variable name with userId
  final String? userId;
  final String name;
  final String? image;
  final String email;
  final String password;

  const UserApiModel({
    this.userId,
    required this.name,
    this.image,
    required this.email,
    required this.password,
  });

  const UserApiModel.empty()
      : userId = '',
        name = '',
        image = '',
        email = '',
        password = '';

  // From JSON
  factory UserApiModel.fromJson(Map<String, dynamic> json) {
    return UserApiModel(
      userId: json['_id'] as String?,
      name: json['name'] as String,
      image: json['image'] as String?,
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': userId,
      'name': name,
      'image': image,
      'email': email,
      'password': password,
    };
  }

  // Convert API Object to Entity
  UserEntity toEntity() => UserEntity(
        userId: userId,
        name: name,
        image: image,
        email: email,
        password: password,
      );

  // Convert Entity to API Object
  factory UserApiModel.fromEntity(UserEntity entity) {
    return UserApiModel(
      userId: entity.userId,
      name: entity.name,
      image: entity.image,
      email: entity.email,
      password: entity.password,
    );
  }

  // Convert API List to Entity List
  static List<UserEntity> toEntityList(List<UserApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  List<Object?> get props => [
        userId,
        name,
        email,
        image,
        password,
      ];
}
