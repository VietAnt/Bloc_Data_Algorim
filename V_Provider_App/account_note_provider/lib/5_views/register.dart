// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:account_note_provider/3_provider/auth_provider.dart';
import 'package:account_note_provider/styles/styles.dart';
import 'package:account_note_provider/utils/validate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
            child: RegisterForm(),
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String name;
  late String email;
  late String password;
  late String passwordConfirm;
  String message = '';

  Map response = new Map();

  Future<void> submit() async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      response = await Provider.of<AuthProvider>(context)
          .register(name, email, password, passwordConfirm);
      if (response['success']) {
        Navigator.pop(context);
      } else {
        setState(() {
          message = response['message'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Register Account',
            textAlign: TextAlign.center,
            style: Styles.h1,
          ),
          SizedBox(height: 10.0),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Styles.error,
          ),
          SizedBox(height: 30.0),
          TextFormField(
              decoration: Styles.input.copyWith(
                hintText: 'Name',
              ),
              validator: (value) {
                name = value!.trim();
                return Validate.requiredField(value, 'Name is required.');
              }),
          SizedBox(height: 15.0),
          TextFormField(
              decoration: Styles.input.copyWith(
                hintText: 'Email',
              ),
              validator: (value) {
                email = value!.trim();
                return Validate.validateEmail(value);
              }),
          SizedBox(height: 15.0),
          TextFormField(
              obscureText: true,
              decoration: Styles.input.copyWith(
                hintText: 'Password',
              ),
              validator: (value) {
                password = value!.trim();
                return Validate.requiredField(value, 'Password is required.');
              }),
          SizedBox(height: 15.0),
          TextFormField(
              obscureText: true,
              decoration: Styles.input.copyWith(
                hintText: 'Password Confirm',
              ),
              validator: (value) {
                passwordConfirm = value!.trim();
                return Validate.requiredField(
                    value, 'Password confirm is required.');
              }),
          SizedBox(height: 15.0),
          TextButton(
              onPressed: submit,
              child: Text(
                'Register',
              )),
        ],
      ),
    );
  }
}
