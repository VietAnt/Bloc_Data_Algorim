import 'package:flutter/material.dart';
import 'package:login_jwt_provider/models/user_model.dart';
import 'package:login_jwt_provider/services/user_service.dart';

// //Todo: UserProvier
class UserProvider extends ChangeNotifier {
  final _service = UserService();
  bool isLoading = false;

  List<User> _users = [];
  List<User> get users => _users;

  Future<void> getAllUsers() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.getAll();

    _users = response;
    isLoading = false;
    notifyListeners();
  }
}
