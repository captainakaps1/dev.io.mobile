import 'package:gods_eye/models/camera_data/CameraData.dart';
import 'package:gods_eye/models/child/child.dart';
import 'package:gods_eye/models/session/Session.dart';
import 'package:gods_eye/models/sub_stream_model/camera.dart';
import 'package:gods_eye/models/teacher/teacher.dart';
import 'package:gods_eye/models/teachers/TeachersData.dart';
import 'package:gods_eye/models/user/UserData.dart';
import 'package:gods_eye/models/util_model/UserUtil.dart';
import 'package:hive/hive.dart';

class Commons {
  static void registerAdapters() {
    Hive.registerAdapter(SessionAdapter());
    Hive.registerAdapter(UserDataAdapter());
    Hive.registerAdapter(ChildAdapter());
    Hive.registerAdapter(TeachersDataAdapter());
    Hive.registerAdapter(TeacherAdapter());
    Hive.registerAdapter(UserUtilAdapter());
    Hive.registerAdapter(CameraDataAdapter());
    Hive.registerAdapter(CameraAdapter());
  }

  static Future<bool> openHiveBoxes() async {
    bool go;
    await Hive.openBox<Session>('session');
    await Hive.openBox<UserData>('user_data');
    await Hive.openBox<TeachersData>('teachers_data');
    await Hive.openBox<UserUtil>('util');
    await Hive.openBox<CameraData>('cam').then((value) {
      go = true;
    });
    return go;
  }
}
