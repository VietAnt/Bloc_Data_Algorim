import 'package:flutter/material.dart';

class InformationScreen extends StatelessWidget {
  final String username;
  final String age;

  const InformationScreen({
    super.key,
    required this.username,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Information'),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: information(
            userNameContent: username,
            ageContent: age,
          ),
        ),
      ),
    );
  }
}

//*Information
Widget information({
  required String userNameContent,
  required String ageContent,
}) {
  return Container(
    padding: const EdgeInsets.only(left: 20, top: 15, right: 20),
    child: Card(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const Text('Thông Tin'),
            const SizedBox(height: 10),
            textWidget(labelText: 'Họ Và Tên', content: userNameContent),
            const SizedBox(height: 10),
            textWidget(labelText: 'Tuổi', content: ageContent)
          ],
        ),
      ),
    ),
  );
}

//*TextWidget
Widget textWidget({required String labelText, required String content}) {
  return Container(
    child: Row(
      children: [
        Text(
          labelText,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(content),
      ],
    ),
  );
}
