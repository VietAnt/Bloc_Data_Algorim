//Todo:Bài tập 10: Viết chương trình kiểm tra xem một chuỗi có phải là palindrome hay không.

bool isPalindrome(String str) {
  String reversedStr = str.split('').reversed.join();
  return str.toLowerCase() == reversedStr.toLowerCase();
}

void main() {
  String str = "Madam";
  if (isPalindrome(str)) {
    print("$str là chuỗi palindrome");
  } else {
    print("$str không là chuỗi palindrome");
  }
}
