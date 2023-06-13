import 'package:ebank_local/Bloc_State/card/card_bloc.dart';
import 'package:ebank_local/Helper/selected_category.dart';
import 'package:ebank_local/Model/card_model.dart';
import 'package:ebank_local/Widgets/selected_color.dart';
import 'package:ebank_local/Widgets/text_input.dart';
import 'package:ebank_local/Widgets/text_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowCardPage extends StatefulWidget {
  final CardModel card;
  final int index;

  const ShowCardPage({
    super.key,
    required this.card,
    required this.index,
  });

  @override
  State<ShowCardPage> createState() => _ShowCardPageState();
}

class _ShowCardPageState extends State<ShowCardPage> {
  late TextEditingController _cardHolderNameController;
  late TextEditingController _cardNumberController;
  late TextEditingController _expDateController;
  late TextEditingController _cvvController;

  @override
  void initState() {
    _cardHolderNameController =
        TextEditingController(text: widget.card.cardHolderName);
    _cardNumberController = TextEditingController(text: widget.card.cardNumber);
    _expDateController = TextEditingController(text: widget.card.expDate);
    _cvvController = TextEditingController(text: widget.card.cvv);

    BlocProvider.of<CardBloc>(context).add(
      SelectedColorEvent(widget.card.color!),
    );

    BlocProvider.of<CardBloc>(context).add(
      SelectedCategoryEvent(
        widget.card.category!,
        BlocProvider.of<CardBloc>(context).state.colorCategory,
      ),
    );

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
              cardBloc.add(
                UpdateCardEvent(
                  index: widget.index,
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
