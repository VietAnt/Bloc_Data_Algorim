//Todo: Sắp xếp mảng bằng thuật toán Bubble Sort:
void main() {
  List<int> numbers = [5, 3, 8, 1, 2, 7, 4, 6];

  bubbleSort(numbers);

  print(numbers); // Output: [1, 2, 3, 4, 5, 6, 7, 8]
}

void bubbleSort(List<int> list) {
  int length = list.length;

  for (int i = 0; i < length - 1; i++) {
    for (int j = 0; j < length - i - 1; j++) {
      if (list[j] > list[j + 1]) {
        int temp = list[j];
        list[j] = list[j + 1];
        list[j + 1] = temp;
      }
    }
  }
}
