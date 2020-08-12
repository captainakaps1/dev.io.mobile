import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gods_eye/models/camera_data/CameraData.dart';
import 'package:gods_eye/screens/stream_screen/stream_screen.dart';
import 'package:gods_eye/utils/constants.dart';
import 'package:hive/hive.dart';

class SubStreamCard extends StatelessWidget {
  const SubStreamCard({
    @required this.sImgSrc,
    @required this.sTitle,
    @required this.sIndex,
  });

  final String sImgSrc;
  final String sTitle;
  final int sIndex;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    TextTheme textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        if (Hive.box<CameraData>('cam').get(0).currentCamera != sIndex) {
          Hive.box<CameraData>('cam').get(0).updateCurrentCamera(sIndex);
          Navigator.of(context).pop();
          Navigator.of(context).push(StreamScreen());
        }
      },
      child: Container(
        height: screenHeight * 0.1528,
        width: screenWidth,
        color: (Hive.box<CameraData>('cam').get(0).currentCamera != sIndex)
            ? Colors.transparent
            : kActiveCardColor,
        child: Padding(
          padding: EdgeInsets.only(
            left: screenWidth * 0.062,
          ),
          child: Row(
            children: <Widget>[
              ClipRRect(
                child: Image.asset(
                  sImgSrc,
                  height: screenHeight * 0.105,
                  width: screenWidth * 0.28,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.04,
                ),
                child: Text(
                  sTitle,
                  style: textTheme.headline1.copyWith(
                    color: (Hive.box<CameraData>('cam').get(0).currentCamera !=
                            sIndex)
                        ? Colors.grey
                        : Colors.white,
                    fontSize:
                        (Hive.box<CameraData>('cam').get(0).currentCamera !=
                                sIndex)
                            ? 16
                            : 17,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
