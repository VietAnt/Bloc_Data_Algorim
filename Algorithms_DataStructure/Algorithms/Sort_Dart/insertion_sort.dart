//Todo:Sắp xếp mảng bằng thuật toán Insertion Sort:

void main() {
  List<int> numbers = [5, 3, 8, 1, 2, 7, 4, 6];

  insertionSort(numbers);

  print(numbers); // Output: [1, 2, 3, 4, 5, 6, 7, 8]
}

void insertionSort(List<int> list) {
  int length = list.length;

  for (int i = 1; i < length; i++) {
    int key = list[i];
    int j = i - 1;

    while (j >= 0 && list[j] > key) {
      list[j + 1] = list[j];
      j--;
    }

    list[j + 1] = key;
  }
}
