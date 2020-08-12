import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gods_eye/components/mjpeg.dart';
import 'package:gods_eye/models/session/Session.dart';
import 'package:hive/hive.dart';

class Player extends HookWidget {
  final String urlToStreamVideo;
  final double width;
  final double height;

  Player({this.urlToStreamVideo, this.width, this.height, Key key}) : super(key: key);

  Map<String, String> getHeaders(){
    // open session box
    final sessionBox = Hive.box<Session>('session');

    // get saved session from hive db
    Session session = sessionBox.get(0);

    return session.headers;
  }

  @override
  Widget build(BuildContext context) {
    final isRunning = useState(true);
    return Center(
      child: Mjpeg(
        isLive: isRunning.value,
        stream: urlToStreamVideo,
        headers: getHeaders(),
        width: width,
        height: height,
      ),
    );
  }
}