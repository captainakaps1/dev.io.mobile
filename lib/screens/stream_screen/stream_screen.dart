import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gods_eye/components/player.dart';
import 'package:gods_eye/models/camera_data/CameraData.dart';
import 'package:gods_eye/models/stream_model/stream_data.dart';
import 'package:gods_eye/models/sub_stream_model/camera.dart';
import 'package:gods_eye/screens/stream_screen/close_page_slide_container.dart';
import 'package:gods_eye/screens/stream_screen/stream_fullscreen.dart';
import 'package:gods_eye/screens/stream_screen/sub_stream_list.dart';
import 'package:gods_eye/utils/constants.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:slide_container/slide_container.dart';
import 'package:slide_container/slide_container_controller.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class StreamScreen extends PopupRoute<Null> {
  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => false;

  /// If this is true the page bellow will not be visible when sliding.
  @override
  bool get opaque => false;

  @override
  String get barrierLabel => "Close";

  @override
  Duration get transitionDuration => const Duration(microseconds: 1);

  @override
  Widget buildPage(_, __, ___) => ScreenLayout();
}

class ScreenLayout extends StatefulWidget {
  @override
  ScreenLayoutState createState() => ScreenLayoutState();
}

class ScreenLayoutState extends State<ScreenLayout> {
  final SlideContainerController slideContainerController =
      SlideContainerController();

  String urlToStreamVideo;

  UnmodifiableListView<Camera> get cameraStreams {
    return UnmodifiableListView(Hive.box<CameraData>('cam')
        .get(0)
        .cameraStreams[Provider.of<StreamData>(context).currentStreamTitle]);
  }

  int get cameraCount {
    return Hive.box<CameraData>('cam')
        .get(0)
        .cameraStreams[Provider.of<StreamData>(context).currentStreamTitle]
        .length;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      urlToStreamVideo =
          cameraStreams[Hive.box<CameraData>('cam').get(0).currentCamera]
              .streamSrc;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    TextTheme textTheme = Theme.of(context).textTheme;

    return WillPopScope(
      onWillPop: () async {
        slideContainerController
            .forceSlide(SlideContainerDirection.topToBottom);
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: ClosePageSlideContainer(
            controller: slideContainerController,
            child: Stack(
              children: <Widget>[
                Container(
                  color: kStreamScreenMainColor,
                  width: screenWidth,
                  height: screenHeight,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        height: screenHeight * 0.35,
                        width: screenWidth,
                        color: Colors.black,
                        child: Player(
                          urlToStreamVideo: urlToStreamVideo,
                          width: screenWidth,
                          height: screenHeight * 0.35,
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight * 0.024,
                        left: screenWidth * 0.06,
                        bottom: screenHeight * 0.024,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                Provider.of<StreamData>(context)
                                    .currentStreamTitle,
                                style: textTheme.headline1.copyWith(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.1),
                              ),
                              Text(
                                cameraStreams[Hive.box<CameraData>('cam')
                                        .get(0)
                                        .currentCamera]
                                    .title,
                                style: textTheme.bodyText1.copyWith(
                                    color: Colors.grey,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.9,
                                    fontFamily: 'Roboto'),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
//                              Navigator.of(context).pop();
                              Navigator.popAndPushNamed(
                                  context, StreamFullScreen.id);
                            },
                            child: Padding(
                              padding:
                                  EdgeInsets.only(right: screenWidth * 0.04),
                              child: Icon(
                                AntDesign.arrowsalt,
                                // Icons.fullscreen,
                                color: Colors.white,
                                size: screenHeight * 0.03,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: screenHeight * 0.515,
                      color: kStreamScreenSubColor,
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              top: screenHeight * 0.024,
                              left: screenWidth * 0.047,
                              bottom: screenHeight * 0.024,
                            ),
                            child: Text(
                              "$cameraCount Cameras",
                              style: textTheme.bodyText1.copyWith(
                                  color: Colors.grey,
                                  fontSize: 15.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.9),
                            ),
                          ),
                          ConstrainedBox(
                              constraints: BoxConstraints(maxHeight: 1000),
                              child: SubStreamList()),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
