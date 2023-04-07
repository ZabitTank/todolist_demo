import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_demo/cubit/todo/todo_cubit.dart';
import 'package:todolist_demo/data/repository.dart';
import 'package:todolist_demo/models/todo.dart';

part 'todo_event.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final Repository repository;

  TodoBloc({required this.repository}) : super(TodoState(allTodos: [])) {
    on<InitTodoEvent>(_initTodo);

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

  void _initTodo(InitTodoEvent event, Emitter<TodoState> emit) async {
    final todes = await repository.todoDataProvider.readTodos();
    emit(TodoState(allTodos: todes));
  }

  @override
  void onTransition(Transition<TodoEvent, TodoState> transition) {
    super.onTransition(transition);
  }
}
