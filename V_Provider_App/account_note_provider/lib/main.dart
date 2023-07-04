import 'package:account_note_provider/3_provider/auth_provider.dart';
import 'package:account_note_provider/3_provider/todo_provider.dart';
import 'package:account_note_provider/5_views/loading.dart';
import 'package:account_note_provider/5_views/login.dart';
import 'package:account_note_provider/5_views/password_reset.dart';
import 'package:account_note_provider/5_views/register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '5_views/todos.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => AuthProvider(),
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Router(),
          '/login': (context) => LogIn(),
          '/register': (context) => Register(),
          '/password-reset': (context) => PasswordReset(),
        },
      ),
    ),
  );
}

class Router extends StatelessWidget {
  const Router({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Consumer<AuthProvider>(
      builder: (context, user, child) {
        switch (user.status) {
          case Status.Uninitialized:
            return Loading();
          case Status.Unauthenticated:
            return LogIn();
          case Status.Authenticated:
            return ChangeNotifierProvider(
              create: (context) => TodoProvider(authProvider),
              child: Todos(),
            );
          default:
            return LogIn();
        }
      },
    );
  }
}
