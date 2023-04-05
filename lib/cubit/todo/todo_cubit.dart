import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_demo/data/constants.dart';
import 'package:todolist_demo/models/todo.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit()
      : super(TodoState(
          allTodos: OldDataProvider.allTodos,
        ));

  void addTodo(Todo todo) {
    emit(TodoState(allTodos: [...state.allTodos, todo]));
  }

  void toggleToBeDeleted(Todo todo) {
    todo.toBeDeleted = !todo.toBeDeleted;
    emit(TodoState(allTodos: state.allTodos));
  }

  void toggleIsComplete(Todo todo) {
    if (todo.toBeDeleted) return;
    todo.isComplete = !todo.isComplete;
    emit(TodoState(allTodos: state.allTodos));
  }
}
