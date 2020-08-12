// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserUtil.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserUtilAdapter extends TypeAdapter<UserUtil> {
  @override
  final typeId = 5;

  @override
  UserUtil read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserUtil()..userLoggedIn = fields[0] as bool;
  }

  @override
  void write(BinaryWriter writer, UserUtil obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.userLoggedIn);
  }
}
