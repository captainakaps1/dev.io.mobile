import 'package:hive/hive.dart';

part 'child.g.dart';

@HiveType(typeId: 2)
class Child extends HiveObject{
  @HiveField(0)
  String firstName; 

  @HiveField(1)
  String lastName;

  @HiveField(2) 
  String level;

  @HiveField(3) 
  String imgSrc;

  Child({this.firstName, this.lastName, this.level, this.imgSrc});
}