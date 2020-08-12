import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gods_eye/screens/home_screen/stream_list.dart';
import 'package:gods_eye/utils/custom_icon.dart';

class HomeScreenBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      height: screenHeight * 0.409,
      margin: EdgeInsets.only(left: screenWidth * 0.158),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.048,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Watch others",
                  style: textTheme.headline1.copyWith(
                      fontSize: 22.0, fontFamily: "SF-Pro-Display-Bold"),
                ),
                RotatedBox(
                  quarterTurns: 2,
                  child: Icon(
                    CustomIcons.back_icon,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: screenHeight * 0.358,
            child: StreamList(),
          )
        ],
      ),
    );
  }
}
