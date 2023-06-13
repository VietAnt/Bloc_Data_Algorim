import 'package:ebank_bloc/constants/app_textstyle.dart';
import 'package:ebank_bloc/constants/color_constants.dart';
import 'package:ebank_bloc/model/card_model.dart';
import 'package:ebank_bloc/model/transaction_model.dart';
import 'package:ebank_bloc/widgets/my_card.dart';
import 'package:ebank_bloc/widgets/transaction_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "My Bank",
          style: TextStyle(
            fontFamily: "Poppins",
            color: kPrimaryColor,
          ),
        ),
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage:
                NetworkImage("https://placeimg.com/640/480/people"),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_active_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 10);
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: myCards.length,
                  itemBuilder: (context, index) {
                    return MyCard(
                      card: myCards[index],
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Recent Transaction",
                style: ApptextStyle.BODY_TEXT,
              ),
              const SizedBox(height: 15),
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return TransactionCard(
                    transaction: myTransactions[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
                itemCount: myTransactions.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
