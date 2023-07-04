//Todo: APIService
// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'dart:io';
import 'package:account_note_provider/1_models/user.dart';
import 'package:account_note_provider/3_provider/auth_provider.dart';
import 'package:account_note_provider/utils/exception.dart';
import 'package:account_note_provider/utils/todo_response.dart';
import 'package:http/http.dart' as http;

class ApiService {
  AuthProvider? authProvider;
  String? token;

  /*
   *AuthProvider được truyền vào khi lớp này được khởi tạo.
   *Điều này cung cấp quyền truy cập vào mã thông báo người dùng
   *cần thiết cho lệnh gọi API.
   *Nó cũng cho phép chúng tôi đăng xuất người dùng
   *khi mã thông báo của họ hết hạn.
  */
  ApiService(AuthProvider authProvider) {
    authProvider = authProvider;
    token = authProvider.token;
  }

  final String api = 'https://laravelreact.com/api/v1/todo';

  /*
  * Xác thực mã phản hồi từ lệnh gọi API.
  * 401 cho biết mã thông báo đã hết hạn.
  * 200 hoặc 201 cho biết lệnh gọi API đã thành công.
  */
  void validateResponseStatus(int status, int validStatus) {
    if (status == 401) {
      throw AuthException("401", "Unauthorized");
    }

    if (status != validStatus) {
      throw ApiException(status.toString(), "API Error");
    }
  }

  //Todo: 1.Trả về danh sách todo.
  Future<TodoResponse> getTodos(String status, {String url = ''}) async {
    //*Mặc định là trang đầu tiên nếu không đặt url.
    if ('' == url) {
      url = "$api?status=$status";
    }

    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );

    validateResponseStatus(response.statusCode, 200);

    Map<String, dynamic> apiResponse = json.decode(response.body);
    List<dynamic> data = apiResponse['data'];

    List<Todo> todos = todoFromJson(json.encode(data));
    String next = apiResponse['links']['next'];

    return TodoResponse(todos, next);
  }

  //Todo: 2.Chuyển đổi trạng thái của một việc cần làm.
  Future toggleTodoStatus(int id, String status) async {
    final url = 'https://laravelreact.com/api/v1/todo/$id';

    Map<String, String> body = {
      'status': status,
    };

    final resposne = await http.patch(
      Uri.parse(url),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      body: body,
    );

    validateResponseStatus(resposne.statusCode, 200);
  }

  //Todo: 3.Thêm một việc cần làm mới.
  Future addTodo(String text) async {
    Map<String, String> body = {
      'value': text,
    };

    final response = await http.post(
      Uri.parse(api),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      body: body,
    );

    validateResponseStatus(response.statusCode, 201);

    //*Trả về id của mục mới được tạo.
    Map<String, dynamic> apiResponse = json.decode(response.body);
    int id = apiResponse['id'];
    return id;
  }
}
