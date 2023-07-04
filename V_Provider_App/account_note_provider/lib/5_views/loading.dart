import 'package:account_note_provider/3_provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  initAuthProvider(context) async {
    Provider.of<AuthProvider>(context).initAuthProvider();
  }

  @override
  Widget build(BuildContext context) {
    initAuthProvider(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('To Do App'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
