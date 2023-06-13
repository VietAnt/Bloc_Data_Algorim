// ignore_for_file: unused_local_variable
import 'dart:collection';
import 'dart:core';

//Todo:Trong Dart, bạn có thể sử dụng các cấu trúc dữ liệu sau:
void main() {
//Todo: 1. List: Một danh sách có thể thay đổi được các phần tử.
//Todo: Có thể thêm, xóa và sửa đổi phần tử trong danh sách.
  List<String> fruits = ['Apple', 'Banana', 'Orange'];

//Todo: 2.Set: Một tập hợp duy nhất các phần tử.
//Todo: Các phần tử trong Set không được trùng lặp và không có thứ tự cụ thể.

  Set<String> countries = {'USA', 'Canada', 'Australia'};

//Todo: 3.Map: Một cặp khóa-giá trị, trong đó mỗi khóa là duy nhất và tương ứng với một giá trị.

  Map<String, int> ages = {'John': 30, 'Mary': 25, 'Peter': 40};

//Todo: 4.Queue: Một hàng đợi (Queue) giúp bạn thực hiện các thao tác
//todo: như thêm phần tử vào cuối và xóa phần tử từ đầu.
  Queue<int> numbers = Queue<int>();
  numbers.add(1);
  numbers.add(2);
  numbers.add(3);
  numbers.removeFirst();

//Todo: 5. Stack: Một ngăn xếp (Stack) giúp bạn thực hiện các thao tác như
//Todo: thêm phần tử vào đầu và xóa phần tử từ đầu.
// Stack<int> stack = Stack<int>();
//  stack.push(1);
//  stack.push(2);
//  stack.push(3);
//  stack.pop();

//Todo: 6. Linked List: Một danh sách liên kết giúp bạn thực hiện các thao tác như
//Todo: thêm, xóa và truy cập các phần tử dựa trên liên kết giữa các nút.
// class Node {
//   int value;
//   Node next;

//   Node(this.value);
// }

// class LinkedList {
//   Node head;

//   void insert(int value) {
//     Node newNode = Node(value);
//     newNode.next = head;
//     head = newNode;
//   }
// }

// LinkedList linkedList = LinkedList();
// linkedList.insert(1);
// linkedList.insert(2);
// linkedList.insert(3);

//Todo:Đây chỉ là một số cấu trúc dữ liệu phổ biến trong Dart.
//Todo Ngoài ra, bạn cũng có thể tạo và sử dụng các cấu trúc dữ liệu tùy chỉnh theo nhu cầu của mình.
}
