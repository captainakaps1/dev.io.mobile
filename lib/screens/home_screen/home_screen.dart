import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gods_eye/screens/home_screen/home_screen_bottom.dart';
import 'package:gods_eye/screens/home_screen/home_screen_top.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
//    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: screenHeight * 0,
                right: screenWidth * 0.44,
                child: Opacity(
                  opacity: 0.35,
                  child: SvgPicture.asset(
                    'images/play_time.svg',
                    height: screenHeight * 0.562,
                    width: screenWidth * 0.562,
                  ),
                ),
              ),
              Column(
                children: <Widget>[HomeScreenTop(), HomeScreenBottom()],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
