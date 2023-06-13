import 'package:flutter/material.dart';

//Todo: 1.TextInputWidget
Widget textInputWidget({
  required String labelText,
  required String hinttext,
  required controller,
}) {
  print('Hàm Input Widget được chạy');
  return Container(
    padding: const EdgeInsets.only(
      left: 20,
      top: 15,
      right: 20,
    ),
    child: TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
        hintText: hinttext,
      ),
      controller: controller,
    ),
  );
}

//todo: 2.ConfirmButton
Widget confirmationButton({
  required onPressed,
  required String labelButton,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    child: Text(labelButton),
  );
}

//todo: 3.InformationWidget
Widget informationWidget({
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
            const Text("Thông tin"),
            const SizedBox(height: 10),
            textWidget(labelText: "Họ và tên: ", content: userNameContent),
            const SizedBox(height: 10),
            textWidget(labelText: "Tuổi: ", content: ageContent),
          ],
        ),
      ),
    ),
  );
}

//todo: 4.textWidget
textWidget({required String labelText, required String content}) {
  return Container(
    child: Row(
      children: [
        Text(
          labelText,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(content)
      ],
    ),
  );
}
