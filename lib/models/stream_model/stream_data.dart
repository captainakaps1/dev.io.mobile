import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:gods_eye/models/stream_model/stream.dart';

class StreamData extends ChangeNotifier {
  int _selectedStream = 0;

  List<Stream> _streams = [
    Stream(title: "Your Children's Classroom", imgSrc: "images/streams/class.jpg"),
    Stream(title: "Cafeteria - East", imgSrc: "images/streams/cafe_east.jpg"),
    Stream(title: "Cafeteria - West", imgSrc: "images/streams/cafe_west.jpg"),
    Stream(
        title: "Penguin Room - North",
        imgSrc: "images/streams/penguin_room_north.jpg"),
    Stream(
        title: "Penguin Room - South",
        imgSrc: "images/streams/penguin_room.jpg"),
    Stream(
        title: "Playground - East",
        imgSrc: "images/streams/playground_east.jpg"),
    Stream(
        title: "Playground - South",
        imgSrc: "images/streams/playground_south.jpg"),
    Stream(
        title: "Playground - West",
        imgSrc: "images/streams/playground_west.jpg"),
    Stream(title: "Study - A", imgSrc: "images/streams/study_a.jpg"),
    Stream(title: "Study - B", imgSrc: "images/streams/study_b.jpg"),
    Stream(title: "Study - C", imgSrc: "images/streams/study_c.jpg"),
    Stream(
        title: "Turtle Room - North", imgSrc: "images/streams/turtle_room.jpg"),
    Stream(
        title: "Turtle Room - South",
        imgSrc: "images/streams/turtle_room_south.jpg"),
  ];

  UnmodifiableListView<Stream> get streams {
    return UnmodifiableListView(_streams);
  }

  int get streamCount {
    return _streams.length;
  }

  int get currentStream {
    return _selectedStream;
  }

  String get currentStreamTitle {
    return streams[currentStream].title;
  }

  void updateCurrentStream(int index) {
    _selectedStream = index;
    notifyListeners();
  }
}
