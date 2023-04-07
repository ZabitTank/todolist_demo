part of 'todo_bloc.dart';

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
