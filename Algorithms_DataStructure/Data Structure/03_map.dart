//Todo:Dưới đây là một ví dụ về cách sử dụng Map trong Dart:

void main() {
  // Khởi tạo một Map
  Map<String, int> scores = {
    'John': 95,
    'Sarah': 80,
    'Mike': 90,
  };

  // Truy cập giá trị bằng khóa
  int? johnScore = scores['John'];
  print(johnScore); // Output: 95

  // Thay đổi giá trị bằng khóa
  scores['Sarah'] = 85;
  print(scores); // Output: {John: 95, Sarah: 85, Mike: 90}

  // Thêm một cặp khóa-giá trị mới
  scores['Linda'] = 92;
  print(scores); // Output: {John: 95, Sarah: 85, Mike: 90, Linda: 92}

  // Lặp qua các cặp khóa-giá trị trong Map
  scores.forEach((key, value) {
    print('$key: $value');
  });
  // Output:
  // John: 95
  // Sarah: 85
  // Mike: 90
  // Linda: 92

  // Kiểm tra một khóa có tồn tại trong Map hay không
  bool containsJohn = scores.containsKey('John');
  print(containsJohn); // Output: true

  // Xóa một cặp khóa-giá trị khỏi Map
  scores.remove('Mike');
  print(scores); // Output: {John: 95, Sarah: 85, Linda: 92}

  // Kiểm tra Map có rỗng hay không
  bool isEmpty = scores.isEmpty;
  print(isEmpty); // Output: false

  // Xóa tất cả các cặp khóa-giá trị trong Map
  scores.clear();
  print(scores); // Output: {}

  // Kiểm tra Map có rỗng hay không sau khi xóa
  bool isEmptyAfterClear = scores.isEmpty;
  print(isEmptyAfterClear); // Output: true
}


// Trong ví dụ này, chúng ta đã khởi tạo một Map và thực hiện các hoạt động như truy cập giá trị bằng khóa, thay đổi giá trị, thêm một cặp khóa-giá trị mới, lặp qua các cặp khóa-giá trị, kiểm tra sự tồn tại của một khóa, xóa một cặp khóa-giá trị và kiểm tra tính trống của Map.

// Map trong Dart là một cấu trúc dữ liệu ánh xạ, lưu trữ các cặp khóa-giá trị. Khóa là duy nhất và không thể trùng lặp.

// Đây chỉ là một ví dụ cơ bản về cách sử dụng Map trong Dart. Map cung cấp nhiều phương thức và thuộc tính khác để làm việc với dữ liệu. Bạn có thể tìm hiểu thêm trong tài liệu chính thức của Dart.