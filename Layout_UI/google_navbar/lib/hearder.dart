import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Heart extends StatelessWidget {
  const Heart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Animate(
        effects: [
          FadeEffect(delay: 300.ms, duration: 500.ms),
          const MoveEffect(),
        ],
        child: const Icon(
          Icons.favorite,
          size: 300,
          color: Colors.red,
        ),
      ).then().rotate().then(delay: 100.milliseconds).swap(
            builder: (context, child) => Center(
              child: Column(
                children: [
                  const Text(
                    'With Love',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Icon(
                    Icons.heart_broken_rounded,
                    size: 500,
                    color: Colors.red,
                  ).animate().tint(color: Colors.black).fade(),
                ],
              ),
            ),
          ),
    );
  }
}
