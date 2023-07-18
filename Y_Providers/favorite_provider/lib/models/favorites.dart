//Todo: Favorite
import 'package:flutter/material.dart';

/// Lớp [Favorites] chứa danh sách các mục yêu thích
/// được lưu bởi người dùng.
class Favorite extends ChangeNotifier {
  final List<int> _favoriteItems = [];

  List<int> get items => _favoriteItems;

  //*-->Add
  void add(int itemNo) {
    _favoriteItems.add(itemNo);
    notifyListeners();
  }

  //*-->Remove
  void remove(int itemNo) {
    _favoriteItems.remove(itemNo);
    notifyListeners();
  }
}
