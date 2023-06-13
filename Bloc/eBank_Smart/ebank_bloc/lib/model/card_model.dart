//Todo: CardModel
import 'package:ebank_bloc/constants/color_constants.dart';
import 'package:flutter/material.dart';

class CardModel {
  String? cardHoldName;
  String? cardNumber;
  String? expDate;
  String? cvv;
  Color? cardColor;

  //Todo:
  CardModel({
    this.cardHoldName,
    this.cardNumber,
    this.cvv,
    this.expDate,
    this.cardColor,
  });
}

//Todo: List
List<CardModel> myCards = [
  CardModel(
    cardHoldName: 'John Doe',
    cardNumber: "**** **** **** 1234",
    cvv: "**4",
    expDate: "12/21",
    cardColor: kPrimaryColor,
  ),
  CardModel(
      cardHoldName: "John Doe",
      cardNumber: "**** **** **** 4321",
      cvv: "***1",
      expDate: "01/22",
      cardColor: kSecondaryColor),
];
