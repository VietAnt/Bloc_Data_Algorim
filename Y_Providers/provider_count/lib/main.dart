import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    // Cung cấp model cho tất cả các widget trong ứng dụng. Đang sử dụng
    // ChangeNotifierProvider vì đó là cách đơn giản để xây dựng lại
    // widget khi model thay đổi. Chúng tôi cũng có thể chỉ cần sử dụng
    // Nhà cung cấp, nhưng sau đó chúng ta sẽ phải tự nghe Counter.
    // Đọc tài liệu của Nhà cung cấp để tìm hiểu về tất cả các nhà cung cấp có sẵn.
    ChangeNotifierProvider(
      // Khởi tạo model trong builder. Bằng cách đó, Nhà cung cấp
      // có thể sở hữu vòng đời của Counter, đảm bảo gọi `dispose`
      // khi không cần nữa.
      create: (context) => Counter(),
      child: const MyApp(),
    ),
  );
}

/// Mô hình đơn giản nhất có thể, chỉ với một trường
/// [ChangeNotifier] là một lớp trong `flutter:foundation`. [Bộ đếm] không
/// _không_ phụ thuộc vào Nhà cung cấp.
class Counter with ChangeNotifier {
  int value = 0;

  void increment() {
    value += 1;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            // Người tiêu dùng tìm kiếm tiện ích Nhà cung cấp tổ tiên
            // và truy xuất mô hình của nó (Bộ đếm, trong trường hợp này).
            // Sau đó, nó sử dụng mô hình đó để xây dựng các widget và sẽ kích hoạt
            // xây dựng lại nếu mô hình được cập nhật.
            Consumer<Counter>(
              builder: (context, counter, child) => Text(
                '${counter.value}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Bạn có thể truy cập nhà cung cấp của mình ở bất cứ đâu bạn có quyền truy cập
          // vào ngữ cảnh. Một cách là sử dụng Provider.of<Counter>(context).
          // Gói trình cung cấp cũng định nghĩa các phương thức mở rộng theo ngữ cảnh
          // chính nó. Bạn có thể gọi context.watch<Counter>() trong phương thức xây dựng
          // của bất kỳ tiện ích nào để truy cập trạng thái hiện tại của Bộ đếm và để hỏi
          // Rung để xây dựng lại tiện ích của bạn bất cứ khi nào Bộ đếm thay đổi.
          // Bạn không thể sử dụng các phương thức xây dựng bên ngoài context.watch() vì điều đó
          // thường dẫn đến các lỗi tinh vi. Thay vào đó, bạn nên sử dụng
          // context.read<Counter>(), lấy trạng thái hiện tại
          // nhưng không yêu cầu Flutter xây dựng lại trong tương lai.
          // Vì chúng tôi đang ở trong một cuộc gọi lại sẽ được gọi bất cứ khi nào người dùng
          // nhấn vào FloatingActionButton, chúng ta không ở trong phương thức xây dựng ở đây.
          // Chúng ta nên sử dụng context.read().
          context.read<Counter>().increment();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
