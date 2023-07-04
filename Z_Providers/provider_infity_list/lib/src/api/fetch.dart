//Todo: Fetch
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:infinitelist/src/api/item.dart';
import 'package:infinitelist/src/api/page.dart';

const catalogLength = 200;

/// Hàm này mô phỏng lệnh gọi API REST.
/// Bạn có thể tưởng tượng việc thay thế nó
/// nội dung bằng một cuộc gọi mạng thực tế, giữ nguyên chữ ký.
/// Nó sẽ tìm nạp một trang gồm các mục từ [startingIndex].

Future<ItemPage> fetchPage(int startingIndex) async {
  // Chúng tôi đang mô phỏng độ trễ cố hữu khi thực hiện cuộc gọi mạng.
  await Future<void>.delayed(const Duration(microseconds: 500));

  // Nếu [startingIndex] vượt quá giới hạn của danh mục, một
  // trang trống sẽ được trả về.
  if (startingIndex > catalogLength) {
    return ItemPage(
      items: [],
      hasNext: false,
      startingIndex: startingIndex,
    );
  }

  // Trang của các mục được tạo ở đây.
  return ItemPage(
    items: List.generate(
      min(itemsPerPage, catalogLength - startingIndex),
      (index) => Item(
        color: Colors.primaries[index % Colors.primaries.length],
        price: 50 + (index * 42) % 200,
        name: 'Color #${startingIndex + index}',
      ),
    ),
    // Trả về `false` nếu chúng ta đạt đến [catalogLength].
    hasNext: startingIndex + itemsPerPage < catalogLength,
    startingIndex: startingIndex,
  );
}
