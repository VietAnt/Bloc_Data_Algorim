import 'package:account_note_provider/1_models/user.dart';

//Todo: Response
class TodoResponse {
  final List<Todo> todos;
  final String apiMore;

  TodoResponse(
    this.todos,
    this.apiMore,
  );
}
