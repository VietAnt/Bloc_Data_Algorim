import 'package:flutter/material.dart';
import 'package:widget_base/information_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //*Controller
  TextEditingController? usernameController, birthYearController;
  String userName = "Chưa xác định";
  String age = "Chưa xác định";

  //todo: initState
  @override
  void initState() {
    usernameController = TextEditingController();
    birthYearController = TextEditingController();
    super.initState();
  }

  //todo: dispose
  @override
  void dispose() {
    usernameController!.dispose();
    birthYearController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông Tin Người Dùng'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              //*Ten_Widget
              textInputWidget(
                labelText: "Họ và Tên",
                hintText: "Nhập họ và tên",
                controller: usernameController,
              ),
              textInputWidget(
                labelText: "Năm sinh",
                hintText: "Nhập năm sinh",
                controller: birthYearController,
              ),
              //*Xác_định_Button
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    userName = usernameController!.text;
                    age = (DateTime.now().year -
                            int.parse(birthYearController!.text))
                        .toString();
                  });
                },
                child: const Text('Xác Nhận'),
              ),
              //*Hiển_Thị_Thông_Tin*//
              informationWidget(userNameContent: userName, ageContent: age),

              //*Chuyển_Màn_Hình*//
              TextButton(
                onPressed: () {
                  var route = MaterialPageRoute(
                    builder: (context) => InformationScreen(
                      username: userName,
                      age: age,
                    ),
                  );
                  Navigator.push(context, route);
                },
                child: const Text('Next Page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Todo: WidgetTextInput
Widget textInputWidget({
  required String labelText,
  required String hintText,
  required controller,
}) {
  return Container(
    padding: const EdgeInsets.only(left: 20, top: 15, right: 20),
    child: TextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
        hintText: hintText,
      ),
      controller: controller,
    ),
  );
}

//Todo: information
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
            const Text('Thông Tin'),
            const SizedBox(height: 20),
            textWidget(labelText: "Họ Và Tên", content: userNameContent),
            const SizedBox(height: 20),
            textWidget(labelText: "Tuổi", content: ageContent)
          ],
        ),
      ),
    ),
  );
}

//Todo: TextWidget
Widget textWidget({
  required String labelText,
  required String content,
}) {
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
