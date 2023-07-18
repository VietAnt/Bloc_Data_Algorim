import 'package:flutter/material.dart';
import 'package:login_jwt_provider/providers/auth_provider.dart';
import 'package:login_jwt_provider/providers/user_provider.dart';
import 'package:login_jwt_provider/screens/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Login Token API',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          useMaterial3: true,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
