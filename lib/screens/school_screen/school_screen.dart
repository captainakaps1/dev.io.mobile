import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gods_eye/components/horizontal_line.dart';
import 'package:gods_eye/models/teachers/TeachersData.dart';
import 'package:gods_eye/screens/school_screen/teacher_list.dart';
import 'package:gods_eye/utils/constants.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';

class SchoolScreen extends StatelessWidget {
  // Function to make phone call
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              top: 0.0,
              right: 0.0,
              left: 0.0,
              child: Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 0.04,
                    right: screenWidth * 0.02,
                    top: screenHeight * 0.015),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "School",
                      style: textTheme.headline4.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 0,
                  right: 0,
                  top: screenHeight * 0.088,
                ),
                child: Column(
                  children: <Widget>[
                    SvgPicture.asset(
                      'images/teacher.svg',
                      height: screenHeight * 0.28,
                      width: screenWidth * 0.28,
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    Text(
                      "Headmaster",
                      style: textTheme.bodyText1
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: screenHeight * 0.0087,
                    ),
                    horizontalLine(),
                    SizedBox(
                      height: screenHeight * 0.0087,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Make phone call to contact when teacher card is tapped
                        _makePhoneCall(
                            'tel:${Hive.box<TeachersData>('teachers_data').get(0).headContact}');
                      },
                      child: Container(
                        width: screenWidth * 0.3,
                        child: Column(
                          children: <Widget>[
                            CircularProfileAvatar(
                              "",
                              radius: screenHeight * 0.053,
                              borderWidth: screenWidth * 0.005,
                              borderColor: kPrimaryColor,
                              elevation: 5.0,
                              foregroundColor: Colors.blue.withOpacity(0.5),
                              child: Image.asset(
                                "images/teacher.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: screenHeight * 0.008),
                              child: Text(
                                "${Hive.box<TeachersData>('teachers_data').get(0).headFirstName} ${Hive.box<TeachersData>('teachers_data').get(0).headLastName}",
                                style: textTheme.subtitle2,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: screenHeight * 0.006),
                              child: Text(
                                "${Hive.box<TeachersData>('teachers_data').get(0).headContact}",
                                style: textTheme.caption.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Text(
                      "Teachers",
                      style: textTheme.bodyText1
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: screenHeight * 0.0087,
                    ),
                    horizontalLine(),
                    SizedBox(
                      height: screenHeight * 0.0087,
                    ),
                    ConstrainedBox(
                        constraints:
                            BoxConstraints(maxHeight: screenHeight * 0.2),
                        child: TeachersList()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
