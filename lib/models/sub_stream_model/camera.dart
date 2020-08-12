import 'package:hive/hive.dart';

part 'camera.g.dart';

@HiveType(typeId: 7)
class Camera extends HiveObject{
  @HiveField(0)
  String imgSrc;

  @HiveField(1)
  String title; 

  @HiveField(2)
  String streamSrc;

  Camera({this.imgSrc, this.title, this.streamSrc});
}
