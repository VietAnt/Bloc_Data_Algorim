import 'package:hive/hive.dart';
part 'card_model.g.dart';

@HiveType(typeId: 1)
class CardModel {
  @HiveField(0)
  String? cardHolderName;

  @HiveField(1)
  String? cardNumber;

  @HiveField(2)
  bool? isCompleted;

  @HiveField(3)
  String? expDate;

  @HiveField(4)
  String? cvv;

  @HiveField(5)
  int? color;

  @HiveField(6)
  String? category;

  @HiveField(7)
  DateTime? created;

  CardModel({
    this.cardHolderName,
    this.cardNumber,
    this.isCompleted,
    this.expDate,
    this.cvv,
    this.color,
    this.category,
    this.created,
  });
}
