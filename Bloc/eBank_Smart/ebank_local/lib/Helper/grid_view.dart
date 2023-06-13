//Todo: showModalGridView
import 'package:ebank_local/Widgets/text_title.dart';
import 'package:flutter/material.dart';

void showModalGridView(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: Colors.white60,
    useSafeArea: true,
    builder: (context) => AlertDialog(
      content: Container(
        height: 200,
        child: const Column(
          children: [
            TextTitle(text: 'Option'),
          ],
        ),
      ),
    ),
  );
}
