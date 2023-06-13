//Todo:Dart cung cấp nhiều loại tìm kiếm khác nhau cho việc tìm kiếm trong các cấu trúc dữ liệu khác nhau.
//Todo: Dưới đây là một số ví dụ về các loại tìm kiếm phổ biến trong Dart:

//Todo: 1. Tìm kiếm tuyến tính trong List:
void main1() {
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  int target = 6;
  int index = numbers.indexOf(target);

  if (index != -1) {
    print('$target được tìm thấy tại vị trí $index');
  } else {
    print('$target không tồn tại trong danh sách');
  }
}

//Todo: 2. Tìm kiếm nhị phân trong List đã được sắp xếp:
void main2() {
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  int target = 6;
  int index = binarySearch(numbers, target);

  if (index != -1) {
    print('$target được tìm thấy tại vị trí $index');
  } else {
    print('$target không tồn tại trong danh sách');
  }
}

int binarySearch(List<int> list, int target) {
  int low = 0;
  int high = list.length - 1;

  while (low <= high) {
    int mid = (low + high) ~/ 2;
    if (list[mid] == target) {
      return mid;
    } else if (list[mid] < target) {
      low = mid + 1;
    } else {
      high = mid - 1;
    }
  }

  return -1;
}

//Todo: 3. Tìm kiếm theo khóa trong Map:
void main3() {
  Map<String, int> scores = {
    'John': 95,
    'Sarah': 80,
    'Mike': 90,
  };

  String targetName = 'Sarah';

  if (scores.containsKey(targetName)) {
    int? score = scores[targetName];
    print('$targetName có điểm số là $score');
  } else {
    print('$targetName không tồn tại trong danh sách');
  }
}

//Todo: 4.Tìm kiếm bằng phương thức `where` trong Iterable:
void main4() {
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  int target = 6;
  Iterable<int> foundNumbers = numbers.where((number) => number == target);

  if (foundNumbers.isNotEmpty) {
    print('$target được tìm thấy trong danh sách');
  } else {
    print('$target không tồn tại trong danh sách');
  }
}


//Todo: Đây chỉ là một số ví dụ cơ bản về cách sử dụng các loại tìm kiếm trong Dart.
//Todo: Tùy thuộc vào nhu cầu cụ thể của bạn và cấu trúc dữ liệu, bạn có thể sử dụ 
//Todo: dụng thêm các phương thức tìm kiếm khác như tìm kiếm đệ quy, tìm kiếm theo điều kiện,và nhiều hơn nữa. 
//Todo: Đồng thời, bạn cũng có thể tìm hiểu thêm về các thư viện 
//Todo: và gói mở rộng trong Dart để có các phương pháp tìm kiếm phức tạp hơn và tùy chỉnh cho nhu cầu cụ thể của bạn.