import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:todolist_demo/constants/constants.dart';
import 'package:todolist_demo/models/todo.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit()
      : super(TodoState(
          allTodos: TodoDataProvider.allTodos,
        ));

  @override
  void onChange(Change<TodoState> change) {
    super.onChange(change);
    print("TodoCubit: ${change.currentState.allTodos}");
  }

  void addTodo(Todo todo) {
    emit(TodoState(allTodos: [...state.allTodos, todo]));
  }

  void toggleToBeDeleted(Todo todo) {
    todo.toBeDeleted = !todo.toBeDeleted;
    emit(TodoState(allTodos: state.allTodos));
  }

  void toggleIsComplete(Todo todo) {
    todo.isComplete = !todo.isComplete;
    emit(TodoState(allTodos: state.allTodos));
  }
}
