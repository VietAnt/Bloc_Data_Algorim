//*-->Giai_Thua
int calculateFactorial(int n) {
  int factorial = 1;
  for (int i = 1; i <= n; i++) {
    factorial *= i;
  }
  return factorial;
}

void main() {
  int number = 5;
  int result = calculateFactorial(number);
  print("Giai thừa của $number là $result");
}
