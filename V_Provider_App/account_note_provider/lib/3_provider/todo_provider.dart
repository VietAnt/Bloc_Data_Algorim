// ignore_for_file: unnecessary_new, unnecessary_null_comparison

import 'package:account_note_provider/1_models/user.dart';
import 'package:account_note_provider/2_services/api_services.dart';
import 'package:account_note_provider/utils/exception.dart';
import 'package:account_note_provider/utils/todo_response.dart';
import 'package:flutter/material.dart';
import 'auth_provider.dart';

//Todo:TodoProvider
class TodoProvider extends ChangeNotifier {
  bool _initialized = false;

  //*AuthProvider
  AuthProvider? authProvider;

  //*Lưu trữ các danh sách riêng biệt cho todo mở và đóng.
  List<Todo> _openTodos = [];
  List<Todo> _closedTodos = [];

  //*API được phân trang.
  //*Nếu có nhiều kết quả chúng tôi lưu trữ
  //*url API để tải chúng sau này.
  late String _openTodosApiMore;
  late String _closedTodosApiMore;

  //*API Service
  ApiService? apiService;

  //*Cung cấp quyền truy cập vào các biến riêng tư.
  bool get initialized => _initialized;
  List<Todo> get openTodos => _openTodos;
  List<Todo> get closedTodos => _closedTodos;
  String get openTodosApiMore => _openTodosApiMore;
  String get closedTodosApiMore => _closedTodosApiMore;

  //*Cần có AuthProvider để khởi tạo ApiService của chúng ta.
  //*Điều này cho phép dịch vụ truy cập vào mã
  //*thông báo người dùng và các phương thức của nhà cung cấp.
  TodoProvider(AuthProvider authProvider) {
    apiService = ApiService(authProvider);
    authProvider = authProvider;

    init();
  }

  //*Init
  void init() async {
    try {
      TodoResponse openTodosResponse = await apiService!.getTodos('open');
      TodoResponse closedTodosResponse = await apiService!.getTodos('closed');

      _initialized = true;
      _openTodos = openTodosResponse.todos;
      _openTodosApiMore = openTodosResponse.apiMore;
      _closedTodos = closedTodosResponse.todos;
      _closedTodosApiMore = closedTodosResponse.apiMore;

      notifyListeners();
    } on AuthException {
      // API returned a AuthException, so user is logged out.
      await authProvider!.logOut(true);
    } catch (Exception) {
      print(Exception);
    }
  }

  //*->ADDTODO
  Future<void> addTodo(String text) async {
    try {
      //*Đăng mục mới lên API của chúng tôi.
      int id = await apiService!.addTodo(text);

      //*Nếu không có ngoại lệ nào được ném bởi Dịch vụ API,
      //*chúng tôi thêm mục vào _openTodos.
      Todo todo = new Todo();
      todo.value = text;
      todo.id = id;
      todo.status = 'open';

      List<Todo> openTodosModified = _openTodos;
      openTodosModified.insert(0, todo);

      _openTodos = openTodosModified;
    } on AuthException {
      //*API trả về một AuthException, vì vậy người dùng đã đăng xuất.
      await authProvider!.logOut(true);
    } catch (Exception) {
      print(Exception);
    }
  }

  //*->ToggelTodo
  Future<bool> toggleTodo(Todo todo) async {
    List<Todo> openTodosModified = _openTodos;
    List<Todo> closedTodosModified = _closedTodos;

    //*Nhận trạng thái hiện tại trong trường hợp có lỗi
    //* và trạng thái mới chưa được đặt.
    String? status = todo.status;

    // Get the new status for the the todo.
    String statusModified = todo.status == 'open' ? 'closed' : 'open';

    // Set the todo status to processing while we wait for the API call to complete.
    todo.status = 'processing';
    notifyListeners();

    // Updates the status via an API call.
    try {
      await apiService!.toggleTodoStatus(todo.id!, statusModified);
    } on AuthException {
      // API returned a AuthException, so user is logged out.
      await authProvider!.logOut(true);
      return false;
    } catch (Exception) {
      print(Exception);

      // If API update failed, we set the status back to original state.
      todo.status = status;
      notifyListeners();
      return false;
    }

    // Modify the todo with the new status.
    Todo modifiedTodo = todo;
    modifiedTodo.status = statusModified;

    if (statusModified == 'open') {
      openTodosModified.add(modifiedTodo);
      closedTodosModified.remove(todo);
    }

    if (statusModified == 'closed') {
      closedTodosModified.add(modifiedTodo);
      openTodosModified.remove(todo);
    }

    _openTodos = openTodosModified;
    _closedTodos = closedTodosModified;
    notifyListeners();
    return true;
  }

  //*-->LoadMore
  Future<void> loadMore(String activeTab) async {
    // Set apiMore based on the activeTab.
    String apiMore =
        (activeTab == 'open') ? _openTodosApiMore : _closedTodosApiMore;

    // If there's no more items to load, return early.
    if (apiMore == null) {
      return;
    }

    try {
      // Make the API call to get more todos.
      TodoResponse todosResponse =
          await apiService!.getTodos(activeTab, url: apiMore);

      // Get the current todos for the active tab.
      List<Todo> currentTodos =
          (activeTab == 'open') ? _openTodos : _closedTodos;

      // Combine current todos with new results from API.
      List<Todo> allTodos = [...currentTodos, ...todosResponse.todos];

      if (activeTab == 'open') {
        _openTodos = allTodos;
        _openTodosApiMore = todosResponse.apiMore;
      }

      if (activeTab == 'closed') {
        _closedTodos = allTodos;
        _closedTodosApiMore = todosResponse.apiMore;
      }

      notifyListeners();
    } on AuthException {
      // API returned a AuthException, so user is logged out.
      await authProvider!.logOut(true);
    } catch (Exception) {
      print(Exception);
    }
  }
}
