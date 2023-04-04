import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist_demo/models/todo.dart';

class TodoProvider extends ChangeNotifier {
  List<String> categories = ["Urgent", "Important", "Not Important"];
  String currentDate = DateFormat.yMMMd().format(DateTime.now());

  //test data
  List<Todo> allTodos = [
    Todo(
        title: "Làm Deadline 10/4",
        date: "4/4/2023",
        time: "8:00 AM",
        description: "Chat GPT",
        category: "Urgent"),
    Todo(
        title: "Tập thể dục",
        date: "4/4/2023",
        time: "5:00 PM",
        description: "",
        category: "Not Important"),
    Todo(
        title: "Làm",
        date: "Jan 30, 2023",
        time: "5:00 PM",
        description: "",
        category: "Important"),
  ];

  List<Todo> get deletedTodos {
    return allTodos.where((element) => element.toBeDeleted).toList();
  }

  List<Todo> get completedTodos {
    return allTodos
        .where((element) => element.isComplete && !element.toBeDeleted)
        .toList();
  }

  void addTodo(String title, String description, String date, String time,
      String category) {
    allTodos.add(Todo(
        title: title,
        date: date,
        description: description,
        time: time,
        category: category));
    notifyListeners();
  }

  void toggleToBeDeleted(Todo todo) {
    todo.toBeDeleted = !todo.toBeDeleted;
    notifyListeners();
  }

  void toggleIsComplete(Todo todo) {
    if (todo.toBeDeleted) return;
    todo.isComplete = !todo.isComplete;
    notifyListeners();
  }

  List<Todo> getSearchResults(String task) {
    return allTodos
        .where((element) =>
            RegExp(task, caseSensitive: false).hasMatch(element.title))
        .toList();
  }

  void addCategory(String category) {
    categories.add(category);
    notifyListeners();
  }

  void removeCategory(String category) {
    categories.remove(category);
    notifyListeners();
  }
}
