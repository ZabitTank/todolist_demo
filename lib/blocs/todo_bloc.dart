import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_demo/cubit/todo/todo_cubit.dart';
import 'package:todolist_demo/data/repository.dart';
import 'package:todolist_demo/models/todo.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final Repository repository;

  TodoBloc({required this.repository}) : super(TodoState(allTodos: [])) {
    on<InitTodoEvent>((event, emit) async {
      final todes = await repository.todoDataProvider.readTodos();
      emit(TodoState(allTodos: todes));
    });

    on<AddTodoEvent>((event, emit) =>
        emit(TodoState(allTodos: [...state.allTodos, event.newTodo])));

    on<DeleteTodoEvent>((event, emit) {
      event.todo.toBeDeleted = !event.todo.toBeDeleted;
      emit(TodoState(allTodos: state.allTodos));
    });

    on<CompleteTodoEvent>((event, emit) {
      if (event.todo.toBeDeleted) return;

      event.todo.isComplete = !event.todo.isComplete;
      emit(TodoState(allTodos: state.allTodos));
    });
  }

  @override
  void onTransition(Transition<TodoEvent, TodoState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}

abstract class TodoEvent {}

class InitTodoEvent extends TodoEvent {
  InitTodoEvent();
}

class AddTodoEvent extends TodoEvent {
  Todo newTodo;
  AddTodoEvent({required this.newTodo});
}

class DeleteTodoEvent extends TodoEvent {
  Todo todo;
  DeleteTodoEvent({required this.todo});
}

class CompleteTodoEvent extends TodoEvent {
  Todo todo;
  CompleteTodoEvent({required this.todo});
}
