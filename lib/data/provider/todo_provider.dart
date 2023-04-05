import 'package:todolist_demo/models/todo.dart';

class TodoDataProvider {
  Future<List<Todo>> readTodos() async {
    final todos = [
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

    await Future.delayed(Duration.zero);

    return todos;
  }
}
