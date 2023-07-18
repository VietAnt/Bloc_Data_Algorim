//Todo: UserScreen
import 'package:flutter/material.dart';
//import 'package:login_jwt_provider/providers/auth_provider.dart';
import 'package:login_jwt_provider/providers/user_provider.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: value.users.length,
              itemBuilder: (context, index) {
                final user = value.users[index];
                return ListTile(
                  title: Text(user.email.toString()),
                  subtitle: Text(user.username.toString()),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          userProvider.getAllUsers();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
