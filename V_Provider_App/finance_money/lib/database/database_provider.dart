import 'package:finance_money/constants/icons.dart';
import 'package:finance_money/models/category.dart';
import 'package:finance_money/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//Todo: DatabaseProvider
class DatabaseProvider extends ChangeNotifier {
  //*-->SearchText
  String _searchText = '';
  String get searchText => _searchText;

  set searchText(String value) {
    _searchText = value;
    notifyListeners();
    //Todo: khi giá trị của văn bản tìm kiếm thay đổi,
    //Todo: nó sẽ thông báo cho các widget.
  }

  //*--> Bộ nhớ trong ứng dụng để tạm thời giữ các danh mục Chi phí
  List<ExpenseCategory> _categories = [];
  List<ExpenseCategory> get categories => _categories;
  List<Expense> _expenses = [];

  //*-->//khi văn bản tìm kiếm trống, trả về toàn bộ danh sách, nếu không tìm kiếm giá trị
  List<Expense> get expenses {
    return _searchText != ''
        ? _expenses
            .where((e) =>
                e.title.toLowerCase().contains(_searchText.toLowerCase()))
            .toList()
        : _expenses;
  }

  Database? _database;
  Future<Database> get database async {
    //database directory
    final dbDirectory = await getDatabasesPath();
    //database name
    const dbName = 'expense_tc.db';
    //full path
    final path = join(dbDirectory, dbName);

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb, //will create this separately
    );

    return _database!;
  }

  //create function
  static const categoryTable = 'categoryTable';
  static const expenseTable = 'expenseTable';

  Future<void> _createDb(Database db, int version) async {
    //Todo: Phương thức này chỉ chạy một lần. khi cơ sở dữ liệu đang được tạo
    //Todo: Vì vậy hãy tạo các bảng ở đây và nếu bạn muốn chèn một số giá trị ban đầu chèn nó vào hàm này.

    await db.transaction((txn) async {
      //category table
      await txn.execute('''CREATE TABLE $categoryTable(
        title TEXT,
        entries INTEGER,
        totalAmount TEXT
      )''');

      //expense table
      await txn.execute('''CREATE TABLE $expenseTable(
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       title TEXT,
       amount TEXT,
       date TEXT,
       category TEXT
     )''');

      //Todo: chèn danh mục ban đầu.
      //Todo: điều này sẽ thêm tất cả các danh mục vào bảng danh mục
      //Todo: khởi tạo 'mục nhập' bằng 0 và 'totalAmount' thành 0,0
      for (int i = 0; i < icons.length; i++) {
        await txn.insert(categoryTable, {
          'title': icons.keys.toList()[i],
          'entries': 0,
          'totalAmount': (0.0).toString(),
        });
      }
    });
  }

  //Todo: phương thức tìm nạp danh mục
  Future<List<ExpenseCategory>> fetchCategories() async {
    //get the database
    final db = await database;
    return await db.transaction((txn) async {
      return await txn.query(categoryTable).then((data) {
        //'data': là giá trị tìm nạp của chúng tôi
        //Chuyen doi from Map<String,object> to Map<String,dynamic>
        final converted = List<Map<String, dynamic>>.from(data);
        //tao ExpenseCategory tu 'map' in 'Converted'
        List<ExpenseCategory> nList = List.generate(
          converted.length,
          (index) => ExpenseCategory.fromString(converted[index]),
        );
        //Chuyen gia tri 'categories' thanh 'nList'
        _categories = nList;
        //trả lại '_categories'
        return _categories;
      });
    });
  }

  //Todo: UpdateCategory
  Future<void> updateCategory(
    String category,
    int nEntries,
    double nTotalAmount,
  ) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn
          .update(
        categoryTable,
        {
          'entries': nEntries, //new value of 'entries'
          'totalAmount': nTotalAmount.toString(), //new value of 'totalAmount'
        },
        where: 'title == ?', //in table where the title ==
        whereArgs: [category], //this category
      )
          .then((_) {
        //sau khi cập nhật vào cơ sở dữ liệu.
        // cập nhật nó trong bộ nhớ trong ứng dụng của chúng tôi.
        var file =
            _categories.firstWhere((element) => element.title == category);

        file.entries = nEntries;
        file.totalAmount = nTotalAmount;
        notifyListeners();
      });
    });
  }

  //Todo: Phuong thuc add Expense vao Database
  Future<void> addExpense(Expense expense) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn
          .insert(
        expenseTable,
        expense.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      )
          .then((generatedId) {
        // sau khi chèn vào cơ sở dữ liệu.
        // chúng tôi lưu trữ nó trong bộ nhớ trong ứng dụng với chi phí mới với id được tạo
        final file = Expense(
          id: generatedId,
          title: expense.title,
          amount: expense.amount,
          date: expense.date,
          category: expense.category,
        );
        //thêm nó vào '_expenses'
        _expenses.add(file);
        //thông báo cho người nghe về sự thay đổi giá trị của '_expenses'
        notifyListeners();
        //sau khi chúng tôi chèn chi phí,
        // chúng tôi cần cập nhật 'mục nhập' và 'totalAmount' của 'danh mục' có liên quan
        var ex = findCategory(expense.category);

        updateCategory(
            expense.category, ex.entries + 1, ex.totalAmount + expense.amount);
      });
    });
  }

  //Todo: DeleteExpense
  Future<void> deleteExpense(
    int expId,
    String category,
    double amount,
  ) async {
    final db = await database;

    await db.transaction((txn) async {
      await txn.delete(
        expenseTable,
        where: 'id == ?',
        whereArgs: [expId],
      ).then(
        (_) async {
          //xóa khỏi bộ nhớ trong ứng dụng
          _expenses.removeWhere((element) => element.id == expId);
          notifyListeners();

          // chúng ta cũng phải cập nhật các mục nhập và tổng số tiền
          var ex = findCategory(category);
          updateCategory(category, ex.entries - 1, ex.totalAmount - amount);
        },
      );
    });
  }

  //Todo: fetchExpense
  Future<List<Expense>> fetchExpenses(String category) async {
    final db = await database;
    return await db.transaction((txn) async {
      return await txn.query(
        expenseTable,
        where: 'category == ?',
        whereArgs: [category],
      ).then((data) {
        final converted = List<Map<String, dynamic>>.from(data);
        //
        List<Expense> nList = List.generate(
            converted.length, (index) => Expense.fromString(converted[index]));
        _expenses = nList;
        return _expenses;
      });
    });
  }

  //Todo: fetchAllExpense
  Future<List<Expense>> fetchAllExpenses() async {
    final db = await database;
    return await db.transaction((txn) async {
      return await txn.query(expenseTable).then((data) {
        final converted = List<Map<String, dynamic>>.from(data);
        List<Expense> nList = List.generate(
            converted.length, (index) => Expense.fromString(converted[index]));
        _expenses = nList;
        return _expenses;
      });
    });
  }

  //Todo: Tim_Kiem_Danh_Muc
  ExpenseCategory findCategory(String title) {
    return _categories.firstWhere((element) => element.title == title);
  }

  //Todo: Tinh_Toan_Nhap_Muc_So_Tien
  Map<String, dynamic> calculateEntriesAndAmount(String category) {
    double total = 0.0;
    var list = _expenses.where((element) => element.category == category);
    for (final i in list) {
      total += i.amount;
    }
    return {'entries': list.length, 'totalAmount': total};
  }

  //Todo: Tong_Chi_Phi
  double calculateTotalExpenses() {
    return _categories.fold(
        0.0, (previousValue, element) => previousValue + element.totalAmount);
  }

  //Todo:Tính chi phí tuần
  List<Map<String, dynamic>> calculateWeekExpenses() {
    List<Map<String, dynamic>> data = [];

    // we know that we need 7 entries
    for (int i = 0; i < 7; i++) {
      // 1 total for each entry
      double total = 0.0;
      // subtract i from today to get previous dates.
      final weekDay = DateTime.now().subtract(Duration(days: i));

      // check how many transacitons happened that day
      for (int j = 0; j < _expenses.length; j++) {
        if (_expenses[j].date.year == weekDay.year &&
            _expenses[j].date.month == weekDay.month &&
            _expenses[j].date.day == weekDay.day) {
          // if found then add the amount to total
          total += _expenses[j].amount;
        }
      }

      // add to a list
      data.add({'day': weekDay, 'amount': total});
    }
    // return the list
    return data;
  }
}
