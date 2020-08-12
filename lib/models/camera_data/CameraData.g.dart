// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CameraData.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CameraDataAdapter extends TypeAdapter<CameraData> {
  @override
  final typeId = 6;

  @override
  CameraData read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CameraData()
      ..cameraStreams = (fields[0] as Map)?.map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List)?.cast<Camera>()));
  }

  @override
  void write(BinaryWriter writer, CameraData obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.cameraStreams);
  }
}
