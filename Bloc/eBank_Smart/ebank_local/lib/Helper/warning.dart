//Todo:
import 'package:ebank_local/Widgets/text_title.dart';
import 'package:flutter/material.dart';

void modalWarning(BuildContext context, String text) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black12,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      content: SizedBox(
        height: 250,
        child: Column(
          children: [
            const Row(
              children: [
                TextTitle(
                    text: 'Frave',
                    color: Colors.amber,
                    fontWeight: FontWeight.w500),
                TextTitle(
                  text: 'Develop',
                  fontWeight: FontWeight.w500,
                )
              ],
            ),
            const Divider(),
            const SizedBox(height: 10),
            Container(
              height: 90,
              width: 90,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  colors: [Colors.white, Colors.amber],
                ),
              ),
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.amber,
                ),
                child: const Icon(
                  Icons.priority_high_rounded,
                  color: Colors.white,
                  size: 38,
                ),
              ),
            ),
            const SizedBox(height: 35),
            TextTitle(
              text: text,
              fontSize: 17,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                alignment: Alignment.center,
                height: 35,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const TextTitle(
                  text: 'Ok',
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
