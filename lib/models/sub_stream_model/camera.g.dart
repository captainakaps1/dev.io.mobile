// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CameraAdapter extends TypeAdapter<Camera> {
  @override
  final typeId = 7;

  @override
  Camera read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Camera(
      imgSrc: fields[0] as String,
      title: fields[1] as String,
      streamSrc: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Camera obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.imgSrc)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.streamSrc);
  }
}
