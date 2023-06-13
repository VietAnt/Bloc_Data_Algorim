//Todo:Bài tập 7: Viết chương trình in ra bảng cửu chương từ 1 đến 10.

void main() {
  for (int i = 1; i <= 10; i++) {
    for (int j = 1; j <= 10; j++) {
      print("$i x $j = ${i * j}");
    }
    print("");
  }
}
