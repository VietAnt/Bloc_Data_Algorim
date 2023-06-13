part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

class ShowDataEvent extends TodoEvent {
  @override
  List<Object> get props => [];
}

//Todo: Add Todo
class AddDataEvent extends TodoEvent {
  final String title;
  final String desc;
  final String date;

  const AddDataEvent({
    required this.title,
    required this.desc,
    required this.date,
  });

  @override
  List<Object> get props => [title, desc, date];

  AddDataEvent copyWith({
    String? title,
    String? desc,
    String? date,
  }) {
    return AddDataEvent(
      title: title ?? this.title,
      desc: desc ?? this.desc,
      date: date ?? this.date,
    );
  }
}

//Todo: UpdateDataEvent
class UpdateDataEvent extends TodoEvent {
  final TodoModel toList;

  const UpdateDataEvent(this.toList);

  @override
  List<Object> get props => [toList];
}

//Todo: DeleteDataEvent
class DeleteDataEvent extends TodoEvent {
  final String id;

  const DeleteDataEvent({required this.id});

  DeleteDataEvent copyWith({String? id}) {
    return DeleteDataEvent(id: id ?? this.id);
  }

  @override
  List<Object> get props => [id];
}
