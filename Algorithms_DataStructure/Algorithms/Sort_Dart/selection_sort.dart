//Todo: Sắp xếp mảng bằng thuật toán Selection Sort:

void main() {
  List<int> numbers = [5, 3, 8, 1, 2, 7, 4, 6];

  selectionSort(numbers);

  print(numbers); // Output: [1, 2, 3, 4, 5, 6, 7, 8]
}

void selectionSort(List<int> list) {
  int length = list.length;

  for (int i = 0; i < length - 1; i++) {
    int minIndex = i;

    for (int j = i + 1; j < length; j++) {
      if (list[j] < list[minIndex]) {
        minIndex = j;
      }
    }

    int temp = list[minIndex];
    list[minIndex] = list[i];
    list[i] = temp;
  }
}
