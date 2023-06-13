// Dưới đây là một số ví dụ về cách sử dụng Queue trong Dart:
import 'dart:collection';

void main() {
//Todo: 1. Khởi tạo một Queue và thêm phần tử:
  Queue<int> queue1 = Queue<int>();
  queue1.add(1);
  queue1.add(2);
  queue1.add(3);
  print(queue1); // Output: {1, 2, 3}

//Todo: 2. Lấy phần tử đầu tiên và xóa nó khỏi Queue:
  Queue<int> queue2 = Queue<int>();
  queue2.add(1);
  queue2.add(2);
  queue2.add(3);
  int firstElement = queue2.removeFirst();
  print(firstElement); // Output: 1
  print(queue2); // Output: {2, 3}

//Todo: 3. Kiểm tra xem Queue có trống hay không:
  Queue<int> queue3 = Queue<int>();
  print(queue2.isEmpty); // Output: true

//Todo: 4. Lặp qua các phần tử trong Queue:
  Queue<String> queue4 = Queue<String>();
  queue4.add('apple');
  queue4.add('banana');
  queue4.add('orange');
  for (var fruit in queue3) {
    print(fruit);
  }

//Todo: 5. Xóa tất cả các phần tử trong Queue:
  Queue<int> queue5 = Queue<int>();
  queue5.add(1);
  queue5.add(2);
  queue5.add(3);
  queue5.clear();
  print(queue5); // Output: {}

// Lưu ý rằng để sử dụng Queue, bạn cần import `dart:collection`.
// Đây chỉ là một số ví dụ cơ bản về cách sử dụng Queue trong Dart. Queue cung cấp nhiều phương thức và thuộc tính khác để làm việc với dữ liệu.
// Bạn có thể tìm hiểu thêm trong tài liệu chính thức của Dart.
}
