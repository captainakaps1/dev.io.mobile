import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gods_eye/models/teacher/teacher.dart';
import 'package:gods_eye/models/teachers/TeachersData.dart';
import 'package:gods_eye/screens/school_screen/teacher_card.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TeachersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<TeachersData>('teachers_data').listenable(),
      builder: (context, Box<TeachersData> box, widget) {
        TeachersData teachers = box.get(0);
        List<Teacher> teachersData = teachers.teachers;
        return ListView.builder(
          itemBuilder: (context, index) {
            final teacherData = teachersData[index];
            return TeacherCard(
              imgSrc: teacherData.imgSrc,
              name: "${teacherData.firstName} ${teacherData.lastName}",
              contact: teacherData.contact,
            );
          },
          shrinkWrap: true,
          itemCount: teachersData.length,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
        );
      },
    );
  }
}
