//Todo: Model
class TodoModel {
  String todoTitle;
  bool completed;

  TodoModel({
    required this.todoTitle,
    this.completed = false,
  });

  //*-->Ham_Chuyen_Doi
  void toggleCompleted() {
    completed = !completed;
  }
}
