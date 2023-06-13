import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onote_sqlite/database/db_helper.dart';
import 'package:onote_sqlite/model/todo_model.dart';
import 'package:uuid/uuid.dart';
part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState(todoModel: [])) {
    on<ShowDataEvent>(showData);
    on<AddDataEvent>(_addData);
    on<UpdateDataEvent>(_updateData);
    on<DeleteDataEvent>(_deleteData);
  }

  //Todo: showData
  Future showData(
    ShowDataEvent event,
    Emitter<TodoState> emit,
  ) async {
    final dataList = await DBHelper.selectAll(DBHelper.todoTable);

    final list = dataList
        .map((item) => TodoModel(
              id: item['id'],
              title: item['title'],
              desc: item['description'],
              date: item['date'],
            ))
        .toList();

    emit(state.copyWith(todoModel: list));
    print('SHOW DATA ${list.length}');
  }

  //Todo:_addData
  Future<void> _addData(
    AddDataEvent event,
    Emitter<TodoState> emit,
  ) async {
    Uuid uuid = const Uuid();

    final list = TodoModel(
      id: uuid.v1(),
      title: event.title,
      desc: event.desc,
      date: event.date,
    );
    DBHelper.insert(DBHelper.todoTable, {
      'id': list.id,
      'title': list.title,
      'description': list.desc,
      'date': list.date,
    });

    final newTodos = [...state.todoModel, list];
    emit(state.copyWith(todoModel: newTodos));
  }

  //Todo: _deleteData
  Future<void> _deleteData(
    DeleteDataEvent event,
    Emitter<TodoState> emit,
  ) async {
    final deleteObject =
        state.todoModel.where((TodoModel todo) => todo.id != event.id).toList();

    await DBHelper.deleteById(DBHelper.todoTable, 'id', event.id);

    emit(state.copyWith(todoModel: deleteObject));
  }

  //Todo: _updateData
  Future<void> _updateData(
      UpdateDataEvent event, Emitter<TodoState> emit) async {
    final list = state.todoModel.map((TodoModel todoModel) {
      if (todoModel.id == event.toList.id) {
        //*-->1
        DBHelper.update(
          DBHelper.todoTable,
          'title',
          event.toList.title,
          event.toList.id,
        );
        //*-->2
        DBHelper.update(
          DBHelper.todoTable,
          'description',
          event.toList.desc,
          event.toList.id,
        );
        //*-->3
        DBHelper.update(
          DBHelper.todoTable,
          'date',
          event.toList.date,
          event.toList.id,
        );

        return TodoModel(
          id: event.toList.id,
          title: event.toList.title,
          desc: event.toList.desc,
          date: event.toList.date,
        );
      }
      return todoModel;
    }).toList();
    emit(state.copyWith(todoModel: list));
  }
}
