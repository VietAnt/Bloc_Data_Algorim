//Todo: Bài tập 8: Viết chương trình kiểm tra xem một số có phải là số nguyên tố hay không.

bool isPrimeNumber(int number) {
  if (number < 2) {
    return false;
  }
  for (int i = 2; i <= number / 2; i++) {
    if (number % i == 0) {
      return false;
    }
  }
  return true;
}

void main() {
  int number = 17;
  if (isPrimeNumber(number)) {
    print("$number là số nguyên tố");
  } else {
    print("$number không là số nguyên tố");
  }
}
