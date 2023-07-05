//Todo: CartModel
import 'package:flutter/material.dart';
import 'package:shopper_provider/models/catalog.dart';

class CartModel extends ChangeNotifier {
  //*Sao lưu trường riêng [danh mục]
  late CatalogModel _catalog;

  //*Trạng thái bên trong riêng tư giỏ hàng
  final List<int> itemId = [];

  //*Danh mục hiện tại. Được sử dụng xây dựng các mục từ id
  CatalogModel get catalog => _catalog;

  set catalog(CatalogModel newCatalog) {
    _catalog = newCatalog;
    notifyListeners();
  }

  //*Danh sách mặt hàng trong giỏ hàng
  List<Item> get items => itemId.map((id) => _catalog.getById(id)).toList();

  //*Tổng giá trị hiện tại của tất cả mặt hàng
  int get totalPrice =>
      items.fold(0, (total, current) => total + current.price);

  //*Thêm mặt hàng. Vào giỏ hàng
  void add(Item item) {
    itemId.add(item.id);
    notifyListeners();
  }

  //*Xóa mặt hàng. Vào giỏ hàng
  void remove(Item item) {
    itemId.remove(item.id);
    notifyListeners();
  }
}
