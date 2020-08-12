import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gods_eye/models/stream_model/stream_data.dart';
import 'package:provider/provider.dart';

class StreamCard extends StatelessWidget {
  const StreamCard({
    @required this.imgSrc,
    @required this.title,
    @required this.index,
  });

  final String imgSrc;
  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.036, horizontal: screenWidth * 0.0297),
      child: GestureDetector(
        onTap: () {
          if (Provider.of<StreamData>(context).currentStream != index) {
            Provider.of<StreamData>(context).updateCurrentStream(index);
          }
        },
        child: Container(
          height: screenHeight * 0.3,
          width: screenWidth * 0.35,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(screenHeight * 0.03),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: screenHeight * 0.015,
                    offset: Offset(0.0, screenHeight * 0.015))
              ]),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(screenHeight * 0.03),
                  topRight: Radius.circular(screenHeight * 0.03),
                ),
                child: Image.asset(
                  imgSrc,
                  width: double.infinity,
                  height: screenHeight * 0.191,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.007,
                  left: screenWidth * 0.018,
                  right: screenWidth * 0.018,
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: textTheme.headline1.copyWith(
                    fontFamily: "SF-Pro-Display-Bold",
                    fontSize: 16.0,
                  ),
                ),
              ),
//              Padding(
//                padding: EdgeInsets.only(
//                  top: screenHeight * 0.0001,
//                ),
//              )
            ],
          ),
        ),
      ),
    );
  }
}
