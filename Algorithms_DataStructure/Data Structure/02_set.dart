void main() {
  // Khởi tạo một Set
  Set<String> fruits = Set<String>();

  // Thêm phần tử vào Set
  fruits.add('apple');
  fruits.add('banana');
  fruits.add('orange');
  fruits.add('apple'); // Phần tử trùng lặp không được thêm vào Set

  // In ra tất cả các phần tử trong Set
  for (var fruit in fruits) {
    print(fruit);
  }
  // Output: apple, banana, orange

  // Kiểm tra một phần tử có tồn tại trong Set hay không
  bool containsApple = fruits.contains('apple');
  print(containsApple); // Output: true

  // Xóa một phần tử khỏi Set
  fruits.remove('banana');
  print(fruits); // Output: {apple, orange}

  // Kiểm tra Set có rỗng hay không
  bool isEmpty = fruits.isEmpty;
  print(isEmpty); // Output: false

  // Xóa tất cả các phần tử trong Set
  fruits.clear();
  print(fruits); // Output: {}

  // Kiểm tra Set có rỗng hay không sau khi xóa
  bool isEmptyAfterClear = fruits.isEmpty;
  print(isEmptyAfterClear); // Output: true
}
