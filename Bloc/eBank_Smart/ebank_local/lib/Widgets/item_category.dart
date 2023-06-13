import 'package:ebank_local/Bloc_State/card/card_bloc.dart';
import 'package:ebank_local/Widgets/text_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemCategory extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback onPressed;

  const ItemCategory({
    super.key,
    required this.color,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.only(bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                    border: Border.all(color: color, width: 4.0),
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                ),
                const SizedBox(width: 10),
                TextTitle(text: text, fontSize: 18),
              ],
            ),
            Row(
              children: [
                Container(
                  child: BlocBuilder<CardBloc, CardState>(
                    builder: (_, state) {
                      return state.category == text
                          ? const Icon(Icons.check)
                          : Container();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
