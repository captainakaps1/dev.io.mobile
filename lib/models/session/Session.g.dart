// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Session.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SessionAdapter extends TypeAdapter<Session> {
  @override
  final typeId = 0;

  @override
  Session read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Session()..headers = (fields[0] as Map)?.cast<String, String>();
  }

  @override
  void write(BinaryWriter writer, Session obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.headers);
  }
}
