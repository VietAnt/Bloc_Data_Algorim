import 'package:flutter/material.dart';
import 'package:provider_shopper/models/catalog.dart';

//Todo: Cart_Model
class CartModel extends ChangeNotifier {
  //*Sao lưu trường riêng [danh mục].
  late CatalogModel _catalog;

  //*Trạng thái bên trong, riêng tư của giỏ hàng. Lưu trữ id của từng mục.
  final List<int> _itemIds = [];

  //*Danh mục hiện tại. Được sử dụng để xây dựng các mục từ id số.
  CatalogModel get catalog => _catalog;

  set catalog(CatalogModel newCatlog) {
    _catalog = newCatlog;
    //* Thông báo cho người nghe, trong trường hợp danh mục mới cung cấp thông tin
    //*khác với cái trước. Ví dụ: sự sẵn có của một mặt hàng
    //*có thể đã thay đổi.
    notifyListeners();
  }

  //* Danh sách các mặt hàng trong giỏ hàng.
  List<Item> get items => _itemIds.map((id) => _catalog.getById(id)).toList();

  //*Tổng giá hiện tại của tất cả các mặt hàng.
  int get totalPrice =>
      items.fold(0, (total, current) => total + current.price);

  //*->Thêm [mặt hàng] vào giỏ hàng. Đây là cách duy nhất để sửa đổi giỏ hàng từ bên ngoài.
  void add(Item item) {
    _itemIds.add(item.id);
    //Dòng này nói với [Model] rằng nó nên xây dựng lại các widget
    // Phụ thuộc vào nó.
    notifyListeners();
  }

  //*->Xóa mặt hàng
  void remove(Item item) {
    _itemIds.remove(item.id);
    // Đừng quên yêu cầu các widget phụ thuộc xây dựng lại _mọi lúc_
    // bạn thay đổi mô hình.
    notifyListeners();
  }
}
