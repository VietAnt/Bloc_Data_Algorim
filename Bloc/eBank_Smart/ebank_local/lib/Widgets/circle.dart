import 'package:ebank_local/Bloc_State/card/card_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Circle extends StatelessWidget {
  final int color;
  final VoidCallback onPressed;

  const Circle({
    super.key,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50.0),
      onTap: onPressed,
      child: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(color),
        ),
        child: BlocBuilder<CardBloc, CardState>(
          builder: (_, state) {
            return state.color == color
                ? const Icon(Icons.check, color: Colors.white)
                : Container();
          },
        ),
      ),
    );
  }
}
