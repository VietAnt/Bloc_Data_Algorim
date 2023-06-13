import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintext;

  const TextInput({
    super.key,
    required this.hintext,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        style: GoogleFonts.getFont('Inter'),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintext,
          contentPadding: EdgeInsets.only(left: 10),
        ),
      ),
    );
  }
}
