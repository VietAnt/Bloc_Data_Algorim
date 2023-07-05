//Todo: Item
import 'package:flutter/material.dart';

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

//Todo: CatalogModel
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

  //*Lấy item theo id
  Item getById(int id) => Item(id, itemNames[id % itemNames.length]);

  //*Nhận mục theo vị trí của nó danh mục
  Item getByPosition(int position) {
    return getById(position);
  }
}
