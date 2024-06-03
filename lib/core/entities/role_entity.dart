import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../enums/role.dart';
import '../models/role_model.dart';
part 'role_entity.g.dart';

@HiveType(typeId: 2)
class RoleEntity extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final RoleEnum role;

  const RoleEntity({
    required this.id,
    required this.role,
  });

  @override
  List<Object?> get props => [
        id,
        role,
      ];

  RoleModel? copyWith({
    @HiveField(0) final int? id,
    @HiveField(1) final RoleEnum? role,
  }) {
    return RoleModel(
      id: id ?? this.id,
      role: role ?? this.role,
    );
  }
}
