// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:account_note_provider/styles/styles.dart';
import 'package:flutter/material.dart';

//Todo: TextButton
class TextButtons extends StatelessWidget {
  final String text;
  final onPressed;

  const TextButtons(this.text, this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressed;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Text(
          text,
          style: Styles.p.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
