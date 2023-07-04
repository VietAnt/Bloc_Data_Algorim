// ignore_for_file: unused_local_variable
import 'package:flutter/material.dart';

//Todo: NotificationText
class NotificationText extends StatelessWidget {
  final String text;
  final String type;

  NotificationText(this.text, this.type, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Colors.red;

    if ('info' == type) {
      color = Colors.blue;
    }

    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(color: color),
    );
  }
}
