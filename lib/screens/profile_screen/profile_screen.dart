import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gods_eye/components/horizontal_line.dart';
import 'package:gods_eye/models/user/UserData.dart';
import 'package:gods_eye/screens/login_screen/login_screen.dart';
import 'package:gods_eye/services/user_service.dart';
import 'package:hive/hive.dart';
import 'package:gods_eye/screens/profile_screen/children_list.dart';

class ProfileScreen extends StatelessWidget {
  // user service object
  final UserService service = UserService();

  void _validateLogout(context) async {
    // call log out function 
    service.userLogout().then((res) {
      if (res) Navigator.pushReplacementNamed(context, LoginScreen.id);
    });
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
                      "Profile",
                      style: textTheme.headline4.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    CircularProfileAvatar(
                      "",
                      radius: screenWidth * 0.05,
                      borderWidth: screenWidth * 0.005,
                      borderColor: Colors.white,
                      elevation: 5.0,
                      foregroundColor: Colors.blue.withOpacity(0.5),
                      onTap: () {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text("You clicked avatar")));
                      },
                      child: Image.asset(
                        "images/father.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0.0,
              bottom: 0.0,
              child: Image.asset("images/city.png"),
            ),
            Positioned(
              top: screenHeight * 0.13,
              left: 0.0,
              right: 0.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    'images/profile.svg',
                    height: screenHeight * 0.28,
                    width: screenWidth * 0.28,
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Container(
                    width: screenWidth * 0.7,
                    child: Center(
                      child: Text(
                        "${Hive.box<UserData>('user_data').get(0).firstName} ${Hive.box<UserData>('user_data').get(0).lastName}",
                        style: textTheme.headline5,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      horizontalLine(),
                      SizedBox(
                        width: screenWidth * 0.06,
                      ),
                      horizontalLine()
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.01),
                    child: Text(
                      "Your Children",
                      style: textTheme.bodyText1
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.025),
                      child: ConstrainedBox(
                          constraints:
                              BoxConstraints(maxHeight: screenHeight * 0.2),
                          child: ChildrenList())),
                  SizedBox(height: screenHeight * 0.02),
                  InkWell(
                    onTap: () {
                      _validateLogout(context);
                    },
                    child: Container(
                      width: screenWidth * 0.44,
                      height: screenHeight * 0.075,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color(0xFF17ead9),
                            Colors.blue,
                          ]),
                          borderRadius:
                              BorderRadius.circular(screenHeight * 0.01125),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xFF6078ea).withOpacity(.3),
                                offset: Offset(0.0, screenHeight * 0.01),
                                blurRadius: screenHeight * 0.01)
                          ]),
                      child: Material(
                        color: Colors.transparent,
                        child: Center(
                            child: Text(
                          "LOGOUT",
                          style: textTheme.headline1.copyWith(
                              letterSpacing: 1.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 19.6),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
