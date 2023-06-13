import 'package:ebank_bloc/constants/app_textstyle.dart';
import 'package:ebank_bloc/model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;
  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 60,
                width: 60,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: transaction.color,
                ),
                child: Image.asset(transaction.avatar.toString()),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${transaction.name}',
                    style: ApptextStyle.LISTTILE,
                  ),
                  Text(
                    '${transaction.month}',
                    style: ApptextStyle.LISTTILE_SUB_TITLE,
                  )
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${transaction.currentBalance}',
                    style: ApptextStyle.LISTTILE,
                  ),
                  Row(
                    children: [
                      transaction.changePercentageIndicator == "up"
                          ? const Icon(
                              // ignore: deprecated_member_use
                              FontAwesomeIcons.levelUpAlt,
                              size: 10,
                              color: Colors.green,
                            )
                          : const Icon(
                              FontAwesomeIcons.levelDownAlt,
                              color: Colors.red,
                            ),
                      const SizedBox(width: 5),
                      Text(
                        '${transaction.changePercentage}',
                        style: ApptextStyle.LISTTILE_SUB_TITLE,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
