import 'package:ebank_local/Widgets/text_title.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Color color;
  final double height;
  final double width;
  final double borderRadius;
  final Color textColor;
  final FontWeight fontWeight;
  final double fontSize;
  final VoidCallback? onPressed;

  const ButtonWidget({
    super.key,
    required this.text,
    this.color = const Color(0xff0C6CF2),
    this.height = 50,
    this.width = double.infinity,
    this.borderRadius = 8.0,
    this.textColor = Colors.white,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 18,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          onPressed: onPressed,
          child: TextTitle(
            text: text,
            fontSize: fontSize,
            color: textColor,
            fontWeight: fontWeight,
          )),
    );
  }
}
