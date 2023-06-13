//todo: Dưới đây là một số ví dụ về cách sử dụng List trong Dart:

import 'dart:core';

//todo: 1.Khởi tạo một List và truy cập các phần tử:

void main() {
  List<int> numbers = [1, 2, 3, 4, 5];
  print(numbers[0]); // Output: 1
  print(numbers.length); // Output: 5

//Todo: 2. Thêm phần tử vào List:
  List<String> fruits = ['apple', 'banana'];
  fruits.add('orange');
  print(fruits); // Output: [apple, banana, orange]

//Todo: 3. Xóa phần tử khỏi List:
  List<String> fruits3 = ['apple', 'banana', 'orange'];
  fruits3.remove('banana');
  print(fruits3); // Output: [apple, orange]

//Todo: 4. Lặp qua các phần tử trong List:
  List<String> fruits4 = ['apple', 'banana', 'orange'];
  for (var fruit in fruits4) {
    print(fruit);
  }

//Todo: 5. Sắp xếp List:
  List<int> numbers5 = [3, 1, 2, 5, 4];
  numbers5.sort();
  print(numbers5); // Output: [1, 2, 3, 4, 5]

//Todo:6. Kiểm tra xem một phần tử có tồn tại trong List hay không:
  List<String> fruits6 = ['apple', 'banana', 'orange'];
  bool containsApple = fruits6.contains('apple');
  print(containsApple); // Output: true

//Todo:7. Tạo một List trống và kiểm tra xem nó có rỗng hay không:
  List<int> emptyList = [];
  print(emptyList.isEmpty); // Output: true

//Todo: 8. Sử dụng phương thức map() để chuyển đổi các phần tử trong List:
  List<int> numbers8 = [1, 2, 3, 4, 5];
  List<int> squaredNumbers = numbers8.map((number) => number * number).toList();
  print(squaredNumbers); // Output: [1, 4, 9, 16, 25]

//Todo:Đây chỉ là một số ví dụ cơ bản về cách sử dụng List trong Dart. List cung cấp nhiều phương thức và thuộc tính khác để làm việc với dữ liệu. Bạn có thể tìm hiểu thêm trong tài liệu chính thức của Dart.
}
