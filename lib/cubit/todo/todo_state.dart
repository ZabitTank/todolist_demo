part of 'todo_cubit.dart';

class TodoState {
  List<Todo> allTodos;

  TodoState({required this.allTodos});

  List<Todo> get deletedTodos {
    return allTodos.where((element) => element.toBeDeleted).toList();
  }

  List<Todo> get completedTodos {
    return allTodos
        .where((element) => element.isComplete && !element.toBeDeleted)
        .toList();
  }

  List<Todo> getSearchResults(String task) {
    return allTodos
        .where((element) =>
            element.toBeDeleted == false &&
            RegExp(task, caseSensitive: false).hasMatch(element.title))
        .toList();
  }
}
