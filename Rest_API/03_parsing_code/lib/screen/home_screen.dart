import 'package:flutter/material.dart';
import 'package:parsing_code/model/user.dart';
import 'package:parsing_code/services/user_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users = [];

  @override
  void initState() {
    fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rest API Call'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final color = user.gender == 'male' ? Colors.blue : Colors.red;
          return ListTile(
            // title: Text(user.email),
            // subtitle: Text(user.phone),
            title: Text(user.fullName),
            subtitle: Text(user.location.country),
            textColor: color,
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: fetchUsers,
      //   child: const Icon(Icons.replay_outlined),
      // ),
    );
  }

  Future<void> fetchUsers() async {
    final response = await UserApi.fetchUsers();
    setState(() {
      users = response;
    });
  }
}
