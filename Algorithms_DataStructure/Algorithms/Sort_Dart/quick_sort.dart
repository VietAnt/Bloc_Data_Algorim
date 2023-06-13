//Todo: Sắp xếp mảng bằng thuật toán Quick Sort:
void main() {
  List<int> numbers = [5, 3, 8, 1, 2, 7, 4, 6];

  quickSort(numbers, 0, numbers.length - 1);

  print(numbers); // Output: [1, 2, 3, 4, 5, 6, 7, 8]
}

void quickSort(List<int> list, int low, int high) {
  if (low < high) {
    int pivotIndex = partition(list, low, high);

    quickSort(list, low, pivotIndex - 1);
    quickSort(list, pivotIndex + 1, high);
  }
}

int partition(List<int> list, int low, int high) {
  int pivot = list[high];
  int i = low - 1;

  for (int j = low; j < high; j++) {
    if (list[j] < pivot) {
      i++;

      int temp = list[i];
      list[i] = list[j];
      list[j] = temp;
    }
  }

  int temp = list[i + 1];
  list[i + 1] = list[high];
  list[high] = temp;

  return i + 1;
}

//Todo:Đây chỉ là một số ví dụ cơ bản về cách sử dụng các thuật toán sắp xếp trong Dart. Tùy thuộc vào nhu cầu cụ thể của bạn và cấu trúc dữ liệu,
//Todo: bạn có thể sử dụng các thuật toán khác nhau để sắp xếp dữ liệu của mình.