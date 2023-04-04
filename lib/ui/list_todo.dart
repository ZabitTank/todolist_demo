import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:todolist_demo/providers/todo_provider.dart';
import 'package:todolist_demo/ui/components/add_todo_modal_bottom_sheet.dart';
import 'package:todolist_demo/ui/components/search_bar.dart';
import 'package:todolist_demo/ui/components/todo_tile.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    print("build");
    Color primaryColor = Theme.of(context).primaryColor;
    final provider = Provider.of<TodoProvider>(context);
    var todos = provider.allTodos
        .where(
          (element) => !element.isComplete && !element.toBeDeleted,
        )
        .toList();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (BuildContext context) =>
              Wrap(children: const [AddTaskModalBottomSheet()]),
        ),
        child: const Icon(
          Icons.add,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Expanded(
                  child: SearchBar(),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Visibility(
                  visible: todos.isNotEmpty,
                  replacement: const Center(
                    child: Text(
                      "You have no tasks",
                      style: TextStyle(letterSpacing: 0.1),
                    ),
                  ),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: todos.length,
                      itemBuilder: (context, index) =>
                          TodoTile(todo: todos[index])),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
