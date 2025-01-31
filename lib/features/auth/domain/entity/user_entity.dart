import 'package:equatable/equatable.dart';
class UserEntity extends Equatable {
  final String? userId;
  final String name;
  final String? image;
  final String email;
  final String password;

  const UserEntity({
    this.userId,
    required this.name,
    this.image,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [userId, email];
}
