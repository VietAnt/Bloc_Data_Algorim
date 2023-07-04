//Todo: Expense: Giao_Dich
class Expense {
  final int id; //Id_duy_nhat
  final String title; //Tieu_de
  final double amount; //So_Luong
  final DateTime date; //Thoi_Gian
  final String category; //Danh_Muc

  //*Contructor
  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  //*'Map' to 'Expense'
  factory Expense.fromString(Map<String, dynamic> value) => Expense(
        id: value['id'],
        title: value['title'],
        amount: double.parse(value['amount']),
        date: DateTime.parse(value['date']),
        category: value['category'],
      );

  //*'Expense' to Map
  Map<String, dynamic> toMap() => {
        //Id will automatically
        'title': title,
        'amount': amount.toString(),
        'date': date.toString(),
        'category': category,
      };
}
