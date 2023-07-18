import 'package:flutter/material.dart';
import 'package:login_jwt_provider/screens/home_screen.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng nhập'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Mật khẩu',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final email = emailController.text;
                final password = passwordController.text;

                authProvider.login(email, password).then((success) {
                  if (success) {
                    // Đăng nhập thành công, điều hướng đến màn hình chính
                    var route = MaterialPageRoute(
                        builder: (context) => const HomeScreen());
                    Navigator.push(context, route);
                  } else {
                    // Đăng nhập thất bại, hiển thị thông báo lỗi
                  }
                });
              },
              child: Text('Đăng nhập'),
            ),
          ],
        ),
      ),
    );
  }
}
