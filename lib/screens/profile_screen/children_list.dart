import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gods_eye/models/child/child.dart';
import 'package:gods_eye/models/user/UserData.dart';
import 'package:gods_eye/screens/profile_screen/child_card.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ChildrenList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<UserData>('user_data').listenable(),
      builder: (context, Box<UserData> box, widget){
          UserData _user = box.get(0);
          List<Child> childrenData = _user.children;
          return ListView.builder(
          itemBuilder: (context, index) {
            final childData = childrenData[index];
            return Childcard(
                name: "${childData.firstName} ${childData.lastName}",
                level: childData.level,
                imgSrc: childData.imgSrc);
          },
          shrinkWrap: true,
          itemCount: childrenData.length,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
        );
      },
    );
  }
}
