// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TeachersData.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TeachersDataAdapter extends TypeAdapter<TeachersData> {
  @override
  final typeId = 3;

  @override
  TeachersData read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TeachersData()
      ..headId = fields[0] as int
      ..headFirstName = fields[1] as String
      ..headLastName = fields[2] as String
      ..headContact = fields[3] as String
      ..headEmail = fields[4] as String
      ..headImgSrc = fields[5] as String
      ..teachers = (fields[6] as List)?.cast<Teacher>();
  }

  @override
  void write(BinaryWriter writer, TeachersData obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.headId)
      ..writeByte(1)
      ..write(obj.headFirstName)
      ..writeByte(2)
      ..write(obj.headLastName)
      ..writeByte(3)
      ..write(obj.headContact)
      ..writeByte(4)
      ..write(obj.headEmail)
      ..writeByte(5)
      ..write(obj.headImgSrc)
      ..writeByte(6)
      ..write(obj.teachers);
  }
}
