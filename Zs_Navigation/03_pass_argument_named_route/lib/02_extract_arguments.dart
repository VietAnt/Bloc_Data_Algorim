import 'package:flutter/material.dart';
import 'package:pass_argument_named_route/01_screen_arguments.dart';

//Todo: Extract_Arguments
class ExtractArgumentScreen extends StatelessWidget {
  const ExtractArgumentScreen({super.key});

  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Center(
        child: Text(args.message),
      ),
    );
  }
}
