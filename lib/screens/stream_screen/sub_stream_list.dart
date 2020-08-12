import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gods_eye/models/camera_data/CameraData.dart';
import 'package:gods_eye/models/stream_model/stream_data.dart';
import 'package:gods_eye/models/sub_stream_model/camera.dart';
import 'package:gods_eye/screens/stream_screen/sub_stream_card.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SubStreamList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<CameraData>('cam').listenable(),
        builder: (context, Box<CameraData> box, widget) {
          CameraData cameraData = box.get(0);
          Map<String, List<Camera>> cameraStreams = cameraData.cameraStreams;
          return ListView.builder(
            itemBuilder: (context, index) {
              final camera = cameraStreams[
                  Provider.of<StreamData>(context).currentStreamTitle][index];
              return SubStreamCard(
                sImgSrc: camera.imgSrc,
                sTitle: camera.title,
                sIndex: index,
              );
            },
            shrinkWrap: true,
            itemCount: cameraStreams[
                    Provider.of<StreamData>(context).currentStreamTitle]
                .length,
            physics: BouncingScrollPhysics(),
          );
        });
  }
}
