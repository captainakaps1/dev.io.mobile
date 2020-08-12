import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget horizontalLine() => Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: 80,
        height: 1.0,
        color: Colors.black26.withOpacity(.2),
      ),
    );
