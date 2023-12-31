import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter JWT Login',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const LoginScreen(),
      routes: {
        '/home': (context) => HomeScreen(
            token: ModalRoute.of(context)!.settings.arguments as String),
      },
    );
  }
}
