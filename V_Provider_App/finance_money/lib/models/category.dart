import 'package:finance_money/constants/icons.dart';
import 'package:flutter/material.dart';

//Todo: ExpenseCategory
class ExpenseCategory {
  final String title; //Tieu_De_Danh_Muc
  final IconData icon; //So_bieu_tuong_ko_doi
  int entries = 0; //chi_phi_danh_muc
  double totalAmount = 0.0; //Tong_so_chi_phi_danh_muc

  //*Contructor
  ExpenseCategory({
    required this.title,
    required this.entries,
    required this.totalAmount,
    required this.icon,
  });

  //Todo: Khi chúng tôi lấy dữ liệu từ cơ sở dữ liệu, nó sẽ là 'Bản đồ'.
  //Todo: dể ứng dụng của chúng tôi hiểu dữ liệu,
  //Todo: chúng tôi cần chuyển đổi nó trở lại 'Danh mục chi phí'
  factory ExpenseCategory.fromString(Map<String, dynamic> value) =>
      ExpenseCategory(
        title: value['title'],
        entries: value['entries'],
        totalAmount: double.parse(value['totalAmount']),
        //Todo: nó sẽ tìm kiếm bản đồ 'biểu tượng' và tìm giá trị liên quan đến tiêu đề.
        icon: icons[value['title']]!,
      );

  //Todo: chúng tôi cần một phương pháp để chuyển đổi 'mô hình' này thành 'Bản đồ'.
  //Todo: để chúng tôi có thể chèn nó vào cơ sở dữ liệu
  Map<String, dynamic> toMap() => {
        'title': title,
        'entries': entries,
        //Todo: cơ sở dữ liệu của chúng tôi sẽ không thể lưu trữ các giá trị kép nên chúng tôi chuyển đổi nó thành một chuỗi
        'totalAmount': totalAmount.toString(),
        //Todo: không lưu trữ các biểu tượng trong cơ sở dữ liệu. đó là quá nhiều công việc.
      };
}
