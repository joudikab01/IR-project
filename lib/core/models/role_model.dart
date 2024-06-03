import '../entities/role_entity.dart';
import '../enums/role.dart';

class RoleModel extends RoleEntity {
  const RoleModel({
    required super.id,
    required super.role,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      id: json["id"],
      role: RoleEnum.fromJson(json["name"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": role,
      };
}
