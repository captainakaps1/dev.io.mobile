import 'package:hive/hive.dart';

part 'teacher.g.dart';

@HiveType(typeId: 4)
class Teacher extends HiveObject{
  @HiveField(0)
  int id;

  @HiveField(1)
  String firstName; 

  @HiveField(2)
  String lastName;

  @HiveField(3) 
  String contact;

  @HiveField(4) 
  String imgSrc;

  @HiveField(5) 
  String email;

  Teacher({this.id, this.firstName, this.lastName, this.contact, this.imgSrc, this.email});
}