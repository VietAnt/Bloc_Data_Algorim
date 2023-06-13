// ignore_for_file: prefer_final_fields
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:state_base/resources/strings.dart';
import 'package:state_base/resources/widget_list.dart';
import 'package:state_base/views/saved_information.dart';
import 'package:state_base/views/state_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  //* 1.Tạo ra State  - 2.Gán State - Context. context đại diện cho 1 widget

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController? usernameController, birthYearController;
  String userName = NOT_DEFINE;
  String age = NOT_DEFINE;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  //*3.Khởi tạo state
  @override
  void initState() {
    usernameController = TextEditingController();
    birthYearController = TextEditingController();
    super.initState();
    //*-1. khởi tạo state
    //*-2. được dùng để đặt các lệnh thực thi trước khi build: load dữ liệu từ cơ sở dữ liệu
    //*-3. Context không được hoạt động
  }

  //*4. CHạy khi laod Dependency và khi Dependency thay đổi, lúc này widget có context
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  //*6. Gọi khi widget configuration thay đổi
  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  //*8. Xóa State khỏi Tree, xảy ra khi hủy widget đó
  @override
  void deactivate() {
    super.deactivate();
  }

  //*9.Hủy State
  @override
  void dispose() {
    print('Hàm được chạy, state bị xóa');
    if (!mounted) {
      print('Biến mounted là false');
    }
    super.dispose();
    usernameController!.dispose();
    birthYearController!.dispose();
  }

  //*5.hàm build
  @override
  Widget build(BuildContext context) {
    //*2. mounted = true
    if (mounted) {
      print('Mounted đã được tạo');
    }
    print('Hàm Build được chạy');

    return Scaffold(
      appBar: AppBar(
        title: const Text(USER_INFORMATION),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              //*Tên-Widget
              textInputWidget(
                labelText: USER_NAME,
                hinttext: USER_NAME_HERE,
                controller: usernameController,
              ),
              //*Năm sinh
              textInputWidget(
                labelText: BIRTH_YEAR,
                hinttext: BIRTH_YEAR_HERE,
                controller: birthYearController,
              ),
              //*Xac nhan Button
              ElevatedButton(
                onPressed: () {
                  //Todo: 7.Hàm setState: Build lại toàn bộ màn hình, kể cả các Widget ko liên quan
                  setState(() {
                    userName = usernameController!.text;
                    age = (DateTime.now().year -
                            int.parse(birthYearController!.text))
                        .toString();
                  });
                  stroreInformation(userName: userName, age: age);
                },
                child: const Text(CONFIRM),
              ),
              //*InformationWidget
              informationWidget(
                userNameContent: userName,
                ageContent: age,
              ),
              //*Next Page Button Widget
              TextButton(
                onPressed: () {
                  var route = MaterialPageRoute(
                    builder: (context) =>
                        StateWidget(userName: userName, age: age),
                  );
                  Navigator.push(context, route);
                },
                child: const Text(NEXT_PAGE),
              ),

              //*Saved
              TextButton(
                onPressed: () {
                  Get.to(const SavedInformation());
                },
                child: const Text(VIEW_SAVED_INFORMATION),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //*Lưu thông tin vào SharedPrefernce (key:value): int double, String, Bool
  stroreInformation({required String userName, required String age}) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString("information", "$USER_NAME:$userName\n$AGE:$age");
    print("Saved Information");
  }
}
