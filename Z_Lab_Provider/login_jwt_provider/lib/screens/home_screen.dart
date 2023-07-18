import 'package:flutter/material.dart';
import 'package:login_jwt_provider/screens/user_screen.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    //final isAuthenticated = authProvider.isAuthenticated;
    //final token = authProvider.token;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang chủ'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // if (isAuthenticated)
            //   Text(
            //     'Đăng nhập thành công!\nToken: $token',
            //     style: const TextStyle(fontSize: 24),
            //     textAlign: TextAlign.center,
            //   ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    var route = MaterialPageRoute(
                        builder: (context) => const UserScreen());
                    Navigator.push(context, route);
                  },
                  child: const Text("User Information"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    authProvider.logout();
                    // Đăng xuất, điều hướng đến màn hình đăng nhập
                  },
                  child: const Text('Đăng xuất'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
