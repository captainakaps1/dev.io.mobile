import 'package:gods_eye/models/teacher/teacher.dart';
import 'package:hive/hive.dart';

part 'TeachersData.g.dart';

@HiveType(typeId: 3)
class TeachersData extends HiveObject {
  @HiveField(0)
  int headId;

  @HiveField(1)
  String headFirstName;

  @HiveField(2)
  String headLastName;

  @HiveField(3)
  String headContact;

  @HiveField(4)
  String headEmail;

  @HiveField(5)
  String headImgSrc;

  @HiveField(6)
  List<Teacher> teachers;

  void updateData(Map data) {
    teachers = [];
    List teacherList = data['data'];
    for (var i = 0; i < teacherList.length; i++) {
      if (teacherList[i]['isHeadmaster'] == 1) {
        headId = teacherList[i]['teacherId'];
        headFirstName = teacherList[i]['firstName'];
        headLastName = teacherList[i]['lastName'];
        headContact = teacherList[i]['teacherContact'];
        headEmail = teacherList[i]['teacherEmail'];
        headImgSrc = "images/teacher.jpg";
      } else {
        teachers.add(Teacher(
          id: teacherList[i]['teacherId'],
          firstName: teacherList[i]['firstName'],
          lastName: teacherList[i]['lastName'],
          contact: teacherList[i]['teacherContact'],
          email: teacherList[i]['teacherEmail'],
          imgSrc: "images/teacher.jpg",
        ));
      }
    }
  }
}
