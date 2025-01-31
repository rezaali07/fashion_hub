import 'package:fashion_hub/features/auth/domain/entity/user_entity.dart';

class LoginResponseEntity {
  final UserEntity user;
  final String token;

  LoginResponseEntity({required this.user, required this.token});
}
