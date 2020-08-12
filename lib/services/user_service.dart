import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:gods_eye/models/camera_data/CameraData.dart';
import 'package:gods_eye/models/session/Session.dart';
import 'package:gods_eye/models/teachers/TeachersData.dart';
import 'package:gods_eye/models/user/UserData.dart';
import 'package:gods_eye/models/util_model/UserUtil.dart';
import 'package:hive/hive.dart';

class UserService {
  // login endpoint
  final loginEndpoint =
      'http://godseye-env.eba-gpcz6ppk.us-east-2.elasticbeanstalk.com/parents/login';

  // teachers endpoint
  final teachersEndpoint =
      'http://godseye-env.eba-gpcz6ppk.us-east-2.elasticbeanstalk.com/parents/info/teachers';

  // logout endpoint
  final logoutEndpoint =
      'http://godseye-env.eba-gpcz6ppk.us-east-2.elasticbeanstalk.com/parents/logout';

  // camera data endpoint
  final cameraDataEndpoint =
      'http://godseye-env.eba-gpcz6ppk.us-east-2.elasticbeanstalk.com/parents/info/public_cameras';

  Future<int> userLogin({String email, String password}) async {
    int response;

    // md5 hash password before posting
    var passwordUTF8 = utf8.encode(password); // data being hashed
    var hashedPassword = md5.convert(passwordUTF8);
    Map postData = {
      "email": "$email",
      "password": "$hashedPassword",
    };

    // open session box
    final sessionBox = Hive.box<Session>('session');

    // initialize session
    Session session = Session()..headers = {};

    // use session to post data to backend and await response
    final data = await session.post(loginEndpoint, postData);

    // add session to box
    sessionBox.put(0, session);

    // check if whether login was sccesfull
    if (data.containsKey("failure")) {
      // Login failure(User not found)
      response = 0;
    } else if (data["status"].containsKey("failure")) {
      // Login failure(Wrong password)
      response = 1;
    } else if (data["status"].containsKey("illegal")) {
      // Login failure(User already logged in)
      response = 2;
    } else if (data["status"].containsKey("success")) {
      // Login Success

      // Get user data and store in User_Data Hive Object
      getUserData(data);

      // get children camera data
      getChildrenCamData(data);

      // get camera data
      getCameraData();

      // get teacher data
      getTeachersData(postData);

      response = 3;
    }
    return response;
  }

  Future<bool> userLogout() async {
    bool response;
    // open session box
    final sessionBox = Hive.box<Session>('session');

    // get saved session from hive db
    Session session = sessionBox.get(0);

    // use session to post data to backend and await response
    final data = await session.post(logoutEndpoint, {});

    // validate logout and log user out
    if (data["status"].containsKey("success")) {
      forgetMe();
      response = true;
      session.headers = {};
    } else
      response = false;

    return response;
  }

  void getCameraData() async {
    // open session box
    final sessionBox = Hive.box<Session>('session');

    // get saved session from hive db
    Session session = sessionBox.get(0);

    // use session to post data to backend and await response
    final data = await session.post(cameraDataEndpoint, {});

    // Get camera data and store in CameraData Hive Object
    // open CameraData box
    final cameraBox = Hive.box<CameraData>('cam');

    // initialize camera data
    CameraData cameraData = cameraBox.get(0);

    // update camera data
    cameraData.addCams(data);
  }

  void getChildrenCamData(Map data) {
    // Get camera data and store in CameraData Hive Object
    // open CameraData box
    final cameraBox = Hive.box<CameraData>('cam');

    // initialize camera data
    CameraData cameraData = CameraData();

    // update camera data
    cameraData.addChildrenCams(data);

    // add data to box
    cameraBox.put(0, cameraData);
  }

  void rememberMe() {
    // function to remember user upon login
    // open util box
    final utilBox = Hive.box<UserUtil>('util');

    // set userLoggedIn to true
    UserUtil userUtil = UserUtil()..userLoggedIn = true;

    // add util to box
    utilBox.put(0, userUtil);
  }

  void forgetMe() {
    // function to forget user upon logout
    // open UserUtil box
    final utilBox = Hive.box<UserUtil>('util');

    // get saved userUtil from hive db
    try {
      UserUtil userUtil = utilBox.get(0);

      // set userLoggedIn to false
      userUtil.userLoggedIn = false;

      // add util to box
      utilBox.put(0, userUtil);
    } catch (e) {
      // set userLoggedIn to false
      UserUtil userUtil = UserUtil()..userLoggedIn = false;

      // add util to box
      utilBox.put(0, userUtil);
    }
  }

  void getUserData(Map data) {
    // Get user data and store in User Data Hive Object
    // open UserData box
    final userBox = Hive.box<UserData>('user_data');

    // initialize user data
    UserData user = UserData();

    // update user data
    user.updateData(data);

    // add user to box
    userBox.put(0, user);
  }

  void getTeachersData(Map postData) {
    // get teacher data

    // open session box
    final sessionBox = Hive.box<Session>('session');

    // get saved session from hive db
    Session session = sessionBox.get(0);

    // use session to post data to backend and await response
    session.post(teachersEndpoint, postData).then((value) {
      // retrive data from post request
      var data = value;
      // Get teacher data and store in User_Data Hive Object
      // open UserData box
      final teachersBox = Hive.box<TeachersData>('teachers_data');

      // initialize teachers data
      TeachersData teachersData = TeachersData();

      // update teachers data
      teachersData.updateData(data);

      // add teachers to box
      teachersBox.put(0, teachersData);
    });
  }
}
