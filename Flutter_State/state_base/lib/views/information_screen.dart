import 'package:flutter/material.dart';
import 'package:state_base/resources/widget_list.dart';

class InformationScreen extends StatelessWidget {
  final String userName;
  final String age;

  const InformationScreen({
    super.key,
    required this.userName,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Information"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: informationWidget(
            userNameContent: userName,
            ageContent: age,
          ),
        ),
      ),
    );
  }
}
