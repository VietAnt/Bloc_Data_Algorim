// ignore_for_file: unused_import
import 'package:ebank_local/Bloc_State/card/card_bloc.dart';
import 'package:ebank_local/Bloc_State/general/general_bloc.dart';
import 'package:ebank_local/Model/card_model.dart';
import 'package:ebank_local/Screens/add_card_page.dart';
import 'package:ebank_local/Screens/show_note_page.dart';
import 'package:ebank_local/Widgets/text_title.dart';
import 'package:ebank_local/constants/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:hive_flutter/adapters.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;

  List<String> itemDropDown = ['Edit', 'View', 'Pin Favorite'];

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollControllerApp);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollController.removeListener(_scrollControllerApp);
    super.dispose();
  }

  //Todo: _scrollControllerApp
  void _scrollControllerApp() {
    if (_scrollController.offset > 170) {
      BlocProvider.of<GeneralBloc>(context).add(IsScrollTopAppBarEvent(true));
    } else {
      BlocProvider.of<GeneralBloc>(context).add(IsScrollTopAppBarEvent(false));
    }
  }

  @override
  Widget build(BuildContext context) {
    final cardBloc = BlocProvider.of<CardBloc>(context);
    final box = Hive.box<CardModel>('keepCard');

    return Scaffold(
      backgroundColor: Color(0xffF2F3F7),
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            BlocBuilder<GeneralBloc, GeneralState>(
              builder: (context, state) {
                return SliverAppBar(
                  flexibleSpace: FlexibleSpaceBar(
                    title: AnimatedOpacity(
                      opacity: state.isScrollAppBar ? 1 : 0,
                      duration: const Duration(microseconds: 100),
                      child: const TextTitle(
                        text: 'All Card ',
                        isTitle: true,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    background: Container(
                      color: const Color(0xffF2F3F7),
                      child: AnimatedOpacity(
                        duration: const Duration(microseconds: 100),
                        opacity: !state.isScrollAppBar ? 1 : 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const TextTitle(
                              text: 'All Card',
                              isTitle: true,
                              fontSize: 30,
                              fontWeight: FontWeight.w300,
                            ),
                            BlocBuilder<CardBloc, CardState>(
                              builder: (context, state) {
                                return TextTitle(
                                  text: '${state.noteLength} card',
                                  fontSize: 22,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  expandedHeight: MediaQuery.of(context).size.height * .4,
                  pinned: true,
                  elevation: 0,
                  backgroundColor: const Color(0xffF2F3F7),
                  leading: IconButton(
                    splashRadius: 20,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.menu_outlined,
                      color: Colors.black,
                    ),
                  ),
                  actions: [
                    BlocBuilder<CardBloc, CardState>(
                      builder: (context, state) {
                        return IconButton(
                          splashRadius: 20,
                          onPressed: () {
                            cardBloc.add(ChangedListToGrid(!state.isList));
                          },
                          icon: Icon(
                            state.isList
                                ? Icons.view_agenda_outlined
                                : Icons.grid_view_rounded,
                            color: Colors.black,
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  ValueListenableBuilder(
                    valueListenable: box.listenable(),
                    builder: (_, Box box, __) {
                      cardBloc.add(LengthALLCardEvent(box.length));

                      if (box.values.isEmpty) {
                        return const Center(
                          child: TextTitle(
                            text: 'No Card',
                            color: Colors.grey,
                          ),
                        );
                      }

                      //BlocBuilder:
                      return BlocBuilder<CardBloc, CardState>(
                        builder: (_, state) {
                          return state.isList
                              ? Column(
                                  children: [
                                    ListCard(),
                                    state.noteLength == 5
                                        ? SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.1,
                                          )
                                        : const SizedBox(),
                                  ],
                                )
                              : _GridCard();
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () {
          var route = MaterialPageRoute(builder: (_) => const AddCardPage());
          Navigator.push(context, route);
        },
        child: const CircleAvatar(
          radius: 24,
          backgroundColor: Colors.blue,
          child: Icon(
            Icons.mode_edit_outline,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

//Todo: _ListCard
class ListCard extends StatelessWidget {
  const ListCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cardBloc = BlocProvider.of<CardBloc>(context);
    final box = Hive.box<CardModel>('keepCard');

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemCount: box.values.length,
      itemBuilder: (_, index) {
        CardModel card = box.getAt(index)!;

        return GestureDetector(
          onTap: () {
            var route = MaterialPageRoute(
                builder: (context) => ShowCardPage(card: card, index: index));
            Navigator.push(context, route);
          },
          child: Dismissible(
            key: Key(card.cardHolderName.toString()),
            background: Container(),
            direction: DismissDirection.endToStart,
            secondaryBackground: Container(
              padding: const EdgeInsets.only(right: 35),
              margin: const EdgeInsets.only(bottom: 15),
              alignment: Alignment.centerRight,
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: const Icon(
                Icons.delete_sweep_rounded,
                color: Colors.white,
                size: 40,
              ),
            ),
            onDismissed: (direction) => cardBloc.add(DeleteCardEvent(index)),
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 15),
              height: 200,
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 89, 212, 240),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'CARD NAME',
                                style: ApptextStyle.MY_CARD_SUBTITLE,
                              ),
                              Text(
                                '${card.cardHolderName}',
                                style: ApptextStyle.MY_CARD_TITLE,
                              ),
                            ],
                          ),
                          SizedBox(width: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Bank',
                                style: ApptextStyle.MY_CARD_SUBTITLE,
                              ),
                              Text(
                                '${card.category}',
                                style: ApptextStyle.MY_CARD_TITLE,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        card.cardNumber.toString(),
                        style: ApptextStyle.MY_CARD_TITLE,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "EXP DATE",
                                style: ApptextStyle.MY_CARD_SUBTITLE,
                              ),
                              Text(
                                card.expDate.toString(),
                                style: ApptextStyle.MY_CARD_TITLE,
                              )
                            ],
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Card Type",
                                style: ApptextStyle.MY_CARD_SUBTITLE,
                              ),
                              Text(
                                card.cvv.toString(),
                                style: ApptextStyle.MY_CARD_TITLE,
                              )
                            ],
                          ),
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Text(
                          //       timeago.format(card.created!),
                          //       style: ApptextStyle.MY_CARD_TITLE,
                          //     )
                          //   ],
                          // )
                        ],
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset('assets/icons/mcard.png'),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _GridCard extends StatelessWidget {
  const _GridCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final noteBloc = BlocProvider.of<CardBloc>(context);
    final box = Hive.box<CardModel>('keepCard');

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        childAspectRatio: 2 / 2,
        crossAxisSpacing: 10,
        maxCrossAxisExtent: 500,
        mainAxisExtent: 300,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      itemCount: box.values.length,
      itemBuilder: (_, index) {
        CardModel card = box.getAt(index)!;

        return GestureDetector(
          onTap: () {
            var route = MaterialPageRoute(
              builder: (_) => ShowCardPage(card: card, index: index),
            );
            Navigator.push(context, route);
          },
          child: Dismissible(
            key: Key(card.cardHolderName.toString()),
            direction: DismissDirection.endToStart,
            background: Container(),
            secondaryBackground: Container(
              padding: const EdgeInsets.only(bottom: 35.0),
              margin: const EdgeInsets.only(bottom: 15.0),
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0))),
              child: const Icon(Icons.delete, color: Colors.white, size: 40),
            ),
            onDismissed: (direction) => noteBloc.add(DeleteCardEvent(index)),
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 15),
              height: 400,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 80, 248, 181),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'CARD NAME',
                            style: ApptextStyle.MY_CARD_SUBTITLE,
                          ),
                          Text(
                            '${card.cardHolderName}',
                            style: ApptextStyle.MY_CARD_TITLE,
                          ),
                        ],
                      ),
                      Text(
                        card.cardNumber.toString(),
                        style: ApptextStyle.MY_CARD_SUBTITLE,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "EXP DATE",
                                style: ApptextStyle.MY_CARD_TITLE,
                              ),
                              Text(
                                card.expDate.toString(),
                                style: ApptextStyle.MY_CARD_SUBTITLE,
                              )
                            ],
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "CVV BANK",
                                style: ApptextStyle.MY_CARD_TITLE,
                              ),
                              Text(
                                card.cvv.toString(),
                                style: ApptextStyle.MY_CARD_SUBTITLE,
                              )
                            ],
                          ),
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Text(
                          //       timeago.format(card.created!),
                          //       style: ApptextStyle.MY_CARD_SUBTITLE,
                          //     )
                          //   ],
                          // )
                        ],
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset('assets/icons/mcard.png'),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
