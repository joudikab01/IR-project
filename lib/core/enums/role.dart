import 'package:hive_flutter/hive_flutter.dart';

part 'role.g.dart';

@HiveType(typeId: 3)
enum RoleEnum {
  @HiveField(0)
  user,
  @HiveField(1)
  admin,
  @HiveField(2)
  student;

  //TODO LATER: get enums from backend
  factory RoleEnum.fromJson(String? roleEnum) {
    if (roleEnum == "user" || roleEnum == null) return user;
    if (roleEnum == "super-admin") return admin;
    if (roleEnum == "student") return student;
    throw Exception("undefined");
  }

  static String toJson(RoleEnum roleEnum) {
    if (roleEnum == user) return "user";
    if (roleEnum == admin) return "super-admin";
    if (roleEnum == student) return "student";
    throw Exception("undefined");
  }
}
