import 'package:gods_eye/models/sub_stream_model/camera.dart';
import 'package:hive/hive.dart';

part 'CameraData.g.dart';

@HiveType(typeId: 6)
class CameraData extends HiveObject {
  @HiveField(0)
  Map<String, List<Camera>> cameraStreams = {
    "Your Children's Classroom": [],
    "Cafeteria - East": [
      Camera(
          title: 'Camera 1',
          imgSrc: 'images/cameras/cafEast_cam1.jpeg',
          streamSrc: ''),
      Camera(
          title: 'Camera 2',
          imgSrc: 'images/cameras/cafEast_cam2.jpg',
          streamSrc: ''),
      Camera(
          title: 'Camera 3',
          imgSrc: 'images/cameras/cafEast_cam2.jpg',
          streamSrc: '')
    ],
    "Cafeteria - West": [
      Camera(
          title: 'Camera 1',
          imgSrc: 'images/cameras/cafWest_cam1.jpeg',
          streamSrc: ''),
      Camera(
          title: 'Camera 2',
          imgSrc: 'images/cameras/cafWest_cam2.jpeg',
          streamSrc: '')
    ],
    "Penguin Room - North": [
      Camera(
          title: 'Camera 1',
          imgSrc: 'images/cameras/studyA_cam1.jpg',
          streamSrc: ''),
      Camera(
          title: 'Camera 2',
          imgSrc: 'images/cameras/studyA_cam1.jpg',
          streamSrc: ''),
      Camera(
          title: 'Camera 3',
          imgSrc: 'images/cameras/studyA_cam1.jpg',
          streamSrc: '')
    ],
    "Penguin Room - South": [
      Camera(
          title: 'Camera 1',
          imgSrc: 'images/cameras/studyA_cam1.jpg',
          streamSrc: ''),
      Camera(
          title: 'Camera 2',
          imgSrc: 'images/cameras/studyA_cam1.jpg',
          streamSrc: ''),
      Camera(
          title: 'Camera 3',
          imgSrc: 'images/cameras/studyA_cam1.jpg',
          streamSrc: '')
    ],
    "Playground - East": [
      Camera(
          title: 'Camera 1',
          imgSrc: 'images/cameras/playGroundEast_cam1.jpeg',
          streamSrc: ''),
      Camera(
          title: 'Camera 2',
          imgSrc: 'images/cameras/playGroundEast_cam2.jpeg',
          streamSrc: ''),
      Camera(
          title: 'Camera 3',
          imgSrc: 'images/cameras/playGroundEast_cam3.jpeg',
          streamSrc: ''),
      Camera(
          title: 'Camera 4',
          imgSrc: 'images/cameras/playGroundEast_cam4.jpeg',
          streamSrc: '')
    ],
    "Playground - South": [
      Camera(
          title: 'Camera 1',
          imgSrc: 'images/cameras/playGroundSouth_cam1.jpeg',
          streamSrc: ''),
      Camera(
          title: 'Camera 2',
          imgSrc: 'images/cameras/playGroundSouth_cam2.jpeg',
          streamSrc: ''),
      Camera(
          title: 'Camera 3',
          imgSrc: 'images/cameras/playGroundSouth_cam3.jpeg',
          streamSrc: '')
    ],
    "Playground - West": [
      Camera(
          title: 'Camera 1',
          imgSrc: 'images/cameras/playGroundSouth_cam1.jpeg',
          streamSrc: ''),
      Camera(
          title: 'Camera 2',
          imgSrc: 'images/cameras/playGroundSouth_cam2.jpeg',
          streamSrc: ''),
      Camera(
          title: 'Camera 3',
          imgSrc: 'images/cameras/playGroundSouth_cam3.jpeg',
          streamSrc: '')
    ],
    "Study - A": [
      Camera(
          title: 'Camera 1',
          imgSrc: 'images/cameras/studyA_cam1.jpg',
          streamSrc: ''),
      Camera(
          title: 'Camera 2',
          imgSrc: 'images/cameras/studyA_cam2.jpeg',
          streamSrc: ''),
      Camera(
          title: 'Camera 3',
          imgSrc: 'images/cameras/studyA_cam1.jpg',
          streamSrc: '')
    ],
    "Study - B": [
      Camera(
          title: 'Camera 1',
          imgSrc: 'images/cameras/studyA_cam1.jpg',
          streamSrc: ''),
      Camera(
          title: 'Camera 2',
          imgSrc: 'images/cameras/studyB_cam1.jpeg',
          streamSrc: ''),
      Camera(
          title: 'Camera 3',
          imgSrc: 'images/cameras/studyA_cam1.jpg',
          streamSrc: '')
    ],
    "Study - C": [
      Camera(
          title: 'Camera 1',
          imgSrc: 'images/cameras/studyA_cam1.jpg',
          streamSrc: ''),
      Camera(
          title: 'Camera 2',
          imgSrc: 'images/cameras/studyA_cam1.jpg',
          streamSrc: ''),
      Camera(
          title: 'Camera 3',
          imgSrc: 'images/cameras/studyA_cam1.jpg',
          streamSrc: '')
    ],
    "Turtle Room - North": [
      Camera(
          title: 'Camera 1',
          imgSrc: 'images/cameras/studyA_cam1.jpg',
          streamSrc: ''),
      Camera(
          title: 'Camera 2',
          imgSrc: 'images/cameras/studyA_cam1.jpg',
          streamSrc: ''),
      Camera(
          title: 'Camera 3',
          imgSrc: 'images/cameras/studyA_cam1.jpg',
          streamSrc: '')
    ],
    "Turtle Room - South": [
      Camera(
          title: 'Camera 1',
          imgSrc: 'images/cameras/studyA_cam1.jpg',
          streamSrc: ''),
      Camera(
          title: 'Camera 2',
          imgSrc: 'images/cameras/studyA_cam1.jpg',
          streamSrc: ''),
      Camera(
          title: 'Camera 3',
          imgSrc: 'images/cameras/studyA_cam1.jpg',
          streamSrc: '')
    ],
  };

  @HiveField(1)
  int _selectedCamera = 0;

  int get currentCamera {
    return _selectedCamera;
  }

  void updateCurrentCamera(int index) {
    _selectedCamera = index;
  }

  void addChildrenCams(Map data) {
    List wardList = data['user']['data'];
    for (var i = 0; i < wardList.length; i++) {
      String firstName = wardList[i]['ward']['wardFirstName'];
      int cameraId = wardList[i]['camera']['cameraId'];
      cameraStreams["Your Children's Classroom"].add(Camera(
          title: "${firstName}'s Class",
          imgSrc: "images/cameras/1.jpg",
          streamSrc:
              "http://godseye-env.eba-gpcz6ppk.us-east-2.elasticbeanstalk.com/parents/feed/${cameraId}"));
    }
  }

  void addCams(Map data) {
    List camData = data["data"];
    List cameraStreamsList = cameraStreams.entries.toList();
    int count = 0;
    for (var i = 1; i < cameraStreamsList.length; i++) {
      List cameraList = cameraStreamsList[i].value;
      for (var j = 0; j < cameraList.length; j++) {
        int cameraId = camData[count];
        cameraList[j].streamSrc =
            "http://godseye-env.eba-gpcz6ppk.us-east-2.elasticbeanstalk.com/parents/feed/${cameraId}";
        count++;
      }
    }
  }
}
