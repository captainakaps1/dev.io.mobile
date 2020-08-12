import 'package:hive/hive.dart';

part 'UserUtil.g.dart';

@HiveType(typeId: 5)
class UserUtil extends HiveObject{
  @HiveField(0)
  bool userLoggedIn = false;
}