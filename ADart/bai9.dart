//Todo: Bài tập 9: Viết chương trình đảo ngược một chuỗi ký tự

String reverseString(String input) {
  String result = "";
  for (int i = input.length - 1; i >= 0; i--) {
    result += input[i];
  }
  return result;
}

void main() {
  String str = "Hello, Dart!";
  String reversedStr = reverseString(str);
  print("Chuỗi đảo ngược: $reversedStr");
}
