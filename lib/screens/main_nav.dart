import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gods_eye/screens/profile_screen/profile_screen.dart';
import 'package:gods_eye/screens/school_screen/school_screen.dart';
import 'package:gods_eye/utils/constants.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'home_screen/home_screen.dart';

class MainNav extends StatefulWidget {
  static String id = 'main_nav';

  @override
  _MainNavState createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> with TickerProviderStateMixin {
  int _screen = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  List<Widget> _screenOptions = <Widget>[
    HomeScreen(),
    SchoolScreen(),
    ProfileScreen(),
  ];

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: BottomNavigationBar(
            key: _bottomNavigationKey,
            currentIndex: 0,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(AntDesign.home,
                      color: (_screen == 0) ? kPrimaryColor : Colors.grey,
                      size: (_screen == 0)
                          ? screenHeight * 0.042
                          : screenHeight * 0.04),
                  title: Text("Home",
                      style: TextStyle(
                          color: (_screen == 0) ? kPrimaryColor : Colors.grey,
                          fontSize: (_screen == 0)
                              ? screenWidth * 0.034
                              : screenWidth * 0.032))),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesome5Solid.school,
                      color: (_screen == 1) ? kPrimaryColor : Colors.grey,
                      size: (_screen == 1)
                          ? screenHeight * 0.042
                          : screenHeight * 0.04),
                  title: Text("School",
                      style: TextStyle(
                          color: (_screen == 1) ? kPrimaryColor : Colors.grey,
                          fontSize: (_screen == 1)
                              ? screenWidth * 0.034
                              : screenWidth * 0.032))),
              BottomNavigationBarItem(
                  icon: Icon(MaterialIcons.person_outline,
                      color: (_screen == 2) ? kPrimaryColor : Colors.grey,
                      size: (_screen == 2)
                          ? screenHeight * 0.042
                          : screenHeight * 0.04),
                  title: Text("Profile",
                      style: TextStyle(
                          color: (_screen == 2) ? kPrimaryColor : Colors.grey,
                          fontSize: (_screen == 2)
                              ? screenWidth * 0.034
                              : screenWidth * 0.032)))
            ],
            onTap: (currentIndex) {
              setState(() {
                _screen = currentIndex;
              });
            },
          ),
          body: _screenOptions.elementAt(_screen),
        ),
      ),
    );
  }
}
