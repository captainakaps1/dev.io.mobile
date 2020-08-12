import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gods_eye/models/stream_model/stream_data.dart';
import 'package:gods_eye/screens/home_screen/clipper.dart';
import 'package:gods_eye/screens/stream_screen/stream_screen.dart';
import 'package:gods_eye/utils/constants.dart';
import 'package:provider/provider.dart';

class HomeScreenTop extends StatefulWidget {
  @override
  _HomeScreenTopState createState() => _HomeScreenTopState();
}

class _HomeScreenTopState extends State<HomeScreenTop> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      height: screenHeight * 0.634,
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: Clipper(),
            child: Container(
              height: screenHeight * 0.542,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, screenHeight * 0.01),
                  blurRadius: screenHeight * 0.01,
                )
              ]),
              child: Stack(
                children: <Widget>[
                  Image.asset(
                      Provider.of<StreamData>(context)
                          .streams[
                              Provider.of<StreamData>(context).currentStream]
                          .imgSrc,
                      fit: BoxFit.cover,
                      width: screenWidth,
                      height: screenHeight),
                  Container(
                    height: screenHeight,
                    width: screenWidth,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          const Color(0x00000000),
                          const Color(0xD9333333)
                        ],
                            stops: [
                          0.0,
                          0.9
                        ],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(0.0, 1.0))),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight * 0.175,
                        left: screenWidth * 0.23,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: screenWidth * 0.5,
                            child: Center(
                              child: Text(
                                Provider.of<StreamData>(context)
                                    .currentStreamTitle,
                                style: textTheme.headline1.copyWith(
                                    fontFamily: "SF-Pro-Display-Bold",
                                    color: Colors.white,
                                    fontSize: 45.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.542,
            right: screenWidth * -0.05,
            child: FractionalTranslation(
              translation: Offset(0.0, -0.5),
              child: Row(
                children: <Widget>[
//                  FloatingActionButton(
//                    backgroundColor: Colors.white,
//                    onPressed: () {},
//                    child: Icon(
//                      Icons.add,
//                      color: kPrimaryColor,
//                    ),
//                  ),
//                  SizedBox(
//                    width: screenWidth * 0.03,
//                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(screenHeight * 0.1),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).push(StreamScreen());
                      },
                      color: kPrimaryColor,
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.0220,
                        horizontal: screenWidth * 0.195,
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Watch Now",
                            style: textTheme.headline1.copyWith(
                                color: Colors.white,
                                fontFamily: 'SF-Pro-Display-Bold',
                                fontSize: 15),
                          ),
                          SizedBox(
                            width: screenWidth * 0.012,
                          ),
                          RotatedBox(
                            quarterTurns: 4,
                            child: Icon(
                              Icons.play_circle_filled,
                              size: screenHeight * 0.035,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
