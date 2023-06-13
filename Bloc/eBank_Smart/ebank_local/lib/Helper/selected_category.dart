// ignore_for_file: unused_local_variable

import 'package:ebank_local/Bloc_State/card/card_bloc.dart';
import 'package:ebank_local/Widgets/item_category.dart';
import 'package:ebank_local/Widgets/text_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showDialogBottom(context) {
  final cardBloc = BlocProvider.of<CardBloc>(context);

  showModalBottomSheet(
    context: context,
    barrierColor: Colors.black,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(40),
      topRight: Radius.circular(40),
    )),
    builder: (context) {
      return Container(
        height: 300,
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue,
                blurRadius: 10,
                spreadRadius: -5.0,
              )
            ]),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            const SizedBox(height: 15),
            const TextTitle(
                text: 'Selected Category', fontSize: 18, isTitle: true),
            const SizedBox(height: 5),
            const Divider(),
            ItemCategory(
              color: Colors.blueGrey,
              text: 'BIDV',
              onPressed: () =>
                  cardBloc.add(SelectedCategoryEvent('BIDV', Colors.blueGrey)),
            ),
            ItemCategory(
              color: Colors.green,
              text: 'VPBank',
              onPressed: () =>
                  cardBloc.add(SelectedCategoryEvent('VPBank', Colors.green)),
            ),
            ItemCategory(
              color: Colors.redAccent,
              text: 'Techcombank',
              onPressed: () => cardBloc
                  .add(SelectedCategoryEvent('Techcombank', Colors.red)),
            ),
            ItemCategory(
                color: Colors.orangeAccent,
                text: 'VIB',
                onPressed: () =>
                    cardBloc.add(SelectedCategoryEvent('VIB', Colors.orange))),
            ItemCategory(
              color: Colors.lightGreen,
              text: 'Vietcombank',
              onPressed: () => cardBloc
                  .add(SelectedCategoryEvent('Vietcombank', Colors.lightGreen)),
            ),
            ItemCategory(
              color: Colors.grey,
              text: 'No Bank',
              onPressed: () => cardBloc.add(SelectedCategoryEvent(
                'No List',
                Colors.grey,
              )),
            ),
          ],
        ),
      );
    },
  );
}
