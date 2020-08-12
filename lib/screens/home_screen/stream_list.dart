import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gods_eye/models/stream_model/stream_data.dart';
import 'package:gods_eye/screens/home_screen/stream_card.dart';
import 'package:provider/provider.dart';

class StreamList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<StreamData>(builder: (context, streamData, child) {
      return ListView.builder(
        itemBuilder: (context, index) {
          final stream = streamData.streams[index];
          return StreamCard(
            imgSrc: stream.imgSrc,
            title: stream.title,
            index: index,
          );
        },
        itemCount: streamData.streamCount,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
      );
    });
  }
}
