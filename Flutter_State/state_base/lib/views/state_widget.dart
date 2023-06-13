import 'package:flutter/material.dart';
import 'package:state_base/resources/widget_list.dart';

class StateWidget extends StatefulWidget {
  final String userName;
  final String age;

  const StateWidget({
    super.key,
    required this.userName,
    required this.age,
  });

  @override
  State<StateWidget> createState() => _StateWidgetState();
}

class _StateWidgetState extends State<StateWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Informaton"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: informationWidget(
            userNameContent: widget.userName,
            ageContent: widget.age,
          ),
        ),
      ),
    );
  }
}
