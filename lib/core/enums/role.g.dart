// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoleEnumAdapter extends TypeAdapter<RoleEnum> {
  @override
  final int typeId = 3;

  @override
  RoleEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return RoleEnum.user;
      case 1:
        return RoleEnum.admin;
      case 2:
        return RoleEnum.student;
      default:
        return RoleEnum.user;
    }
  }

  @override
  void write(BinaryWriter writer, RoleEnum obj) {
    switch (obj) {
      case RoleEnum.user:
        writer.writeByte(0);
        break;
      case RoleEnum.admin:
        writer.writeByte(1);
        break;
      case RoleEnum.student:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoleEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
