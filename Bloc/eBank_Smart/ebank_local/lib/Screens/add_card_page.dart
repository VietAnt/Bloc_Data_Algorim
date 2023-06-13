//Todo: AddCardPage
// ignore_for_file: unused_local_variable

import 'package:ebank_local/Bloc_State/card/card_bloc.dart';
import 'package:ebank_local/Helper/selected_category.dart';
import 'package:ebank_local/Helper/warning.dart';
import 'package:ebank_local/Widgets/selected_color.dart';
import 'package:ebank_local/Widgets/text_input.dart';
import 'package:ebank_local/Widgets/text_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  late TextEditingController _cardHolderNameController;
  late TextEditingController _cardNumberController;
  late TextEditingController _expDateController;
  late TextEditingController _cvvController;

  @override
  void initState() {
    _cardHolderNameController = TextEditingController();
    _cardNumberController = TextEditingController();
    _expDateController = TextEditingController();
    _cvvController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    clearText();
    _cardHolderNameController.clear();
    _cardNumberController.clear();
    _expDateController.clear();
    _cvvController.clear();
    super.dispose();
  }

  void clearText() {
    _cardHolderNameController.clear();
    _cardNumberController.clear();
    _expDateController.clear();
    _cvvController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final cardBloc = BlocProvider.of<CardBloc>(context);

    return Scaffold(
      backgroundColor: const Color(0xffF2F3F7),
      appBar: AppBar(
        backgroundColor: const Color(0xffF2F3F7),
        elevation: 0,
        title: const TextTitle(
          text: 'Add Card',
          fontWeight: FontWeight.bold,
          fontSize: 20,
          isTitle: true,
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Center(
            child: TextTitle(
              text: 'Cancel',
              fontSize: 15,
              color: Color(0xff0C6CF2),
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              if (_cardHolderNameController.text.trim().isNotEmpty &&
                  _cardNumberController.text.trim().isNotEmpty &&
                  _cvvController.text.trim().isNotEmpty &&
                  _expDateController.text.trim().isNotEmpty) {
                cardBloc.add(
                  AddNoteCard(
                    cardHolderName: _cardHolderNameController.text,
                    cardNumber: _cardNumberController.text,
                    isCompleted: false,
                    expDate: _expDateController.text,
                    cvv: _cvvController.text,
                    cardColor: cardBloc.state.color,
                    category: cardBloc.state.category,
                    created: DateTime.now(),
                  ),
                );
                clearText();
                Navigator.pop(context);
              } else {
                modalWarning(context, 'CardHolder and card is required');
              }
            },
            child: Container(
              alignment: Alignment.center,
              width: 60,
              child: const TextTitle(
                text: 'Save',
                fontSize: 15,
                color: Color(0xff0c6cf2),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                TextInput(
                  controller: _cardHolderNameController,
                  hintext: 'HolderName',
                ),
                const SizedBox(height: 20),
                TextInput(
                  controller: _cardNumberController,
                  hintext: 'NumberCard',
                ),
                const SizedBox(height: 20),
                TextInput(
                  controller: _cvvController,
                  hintext: 'Card Type',
                ),
                const SizedBox(height: 20),
                TextInput(
                  controller: _expDateController,
                  hintext: 'ExpDate',
                ),
                const SizedBox(height: 20),
                _Category(),
                const SizedBox(height: 30),
                const SelecetedColors()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//Todo: Category: Danh_Muc
class _Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: 60,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xffF6F8F9),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: TextTitle(text: 'Category'),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            alignment: Alignment.center,
            height: 40,
            width: 170,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(color: Colors.grey, blurRadius: 7, spreadRadius: -5.0)
              ],
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () => showDialogBottom(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<CardBloc, CardState>(
                      builder: (_, state) {
                        return Container(
                          height: 19,
                          width: 19,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: state.colorCategory, width: 4),
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                        );
                      },
                    ),
                    BlocBuilder<CardBloc, CardState>(builder: (_, state) {
                      return TextTitle(
                        text: state.category,
                        fontWeight: FontWeight.w600,
                      );
                    }),
                    const Icon(Icons.expand_more),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
