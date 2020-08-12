import 'package:gods_eye/models/child/child.dart';
import 'package:hive/hive.dart';

part 'UserData.g.dart';

@HiveType(typeId: 1)
class UserData extends HiveObject{
  @HiveField(0)
  int id;

  @HiveField(1)
  String firstName;

  @HiveField(2)
  String lastName;

  @HiveField(3)
  List<Child> children;

  void updateData(Map data){
    id = data['user']['parentId'];
    firstName = data['user']['firstName'];
    lastName = data['user']['lastName'];

    // add children
    children = [];
    List wardList = data['user']['data'];
    for (var i=0; i<wardList.length; i++){
        children.add(Child(
          firstName: wardList[i]['ward']['wardFirstName'],
          lastName: wardList[i]['ward']['wardLastName'],
          level: wardList[i]['classroom']['className'],
          imgSrc: "images/child$i.jpg"
          ));
    }
  }
}