import 'package:flutter/material.dart';

//Todo: Catalog_Model
class CatalogModel {
  static List<String> itemNames = [
    'Code Smell',
    'Control Flow',
    'Interpreter',
    'Recursion',
    'Sprint',
    'Heisenbug',
    'Spaghetti',
    'Hydra Code',
    'Off-By-One',
    'Scope',
    'Callback',
    'Closure',
    'Automata',
    'Bit Shift',
    'Currying',
  ];

  //* Lấy item theo [id].
  //* Trong mẫu này, danh mục là vô hạn, lặp qua [itemNames].
  Item getById(int id) => Item(id, itemNames[id % itemNames.length]);

  //*Nhận mục theo vị trí của nó trong danh mục.
  Item getByPosition(int position) {
    //*Trong trường hợp đơn giản này,
    //*vị trí của một mặt hàng trong danh mục
    //*cũng là id của nó.
    return getById(position);
  }
}

//Todo: Item
class Item {
  final int id;
  final String name;
  final Color color;
  final int price = 42;

  Item(this.id, this.name)
      : color = Colors.primaries[id % Colors.primaries.length];

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Item && other.id == id;
}
