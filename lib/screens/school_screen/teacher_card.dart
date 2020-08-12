import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TeacherCard extends StatelessWidget {
  const TeacherCard({
    @required this.name,
    @required this.contact,
    @required this.imgSrc,
  });

  final String name;
  final String contact;
  final String imgSrc;

  // Function to make phone call
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    TextTheme textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        // Make phone call to contact when teacher card is tapped
        _makePhoneCall('tel:$contact');
      },
      child: Container(
        width: screenWidth * 0.3,
        child: Column(
          children: <Widget>[
            CircularProfileAvatar(
              "",
              radius: screenHeight * 0.053,
              borderWidth: screenWidth * 0.005,
              borderColor: Colors.white,
              elevation: 5.0,
              foregroundColor: Colors.blue.withOpacity(0.5),
              child: Image.asset(
                imgSrc,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: screenHeight * 0.008),
            Text(
              name,
              textAlign: TextAlign.center,
              style: textTheme.subtitle2,
            ),
            SizedBox(height: screenHeight * 0.006),
            Text(
              contact,
              textAlign: TextAlign.center,
              style: textTheme.caption.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
