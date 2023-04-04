import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_demo/providers/todo_provider.dart';
import 'package:todolist_demo/ui/components/add_todo_modal_bottom_sheet.dart';
import 'package:todolist_demo/ui/components/search_bar.dart';
import 'package:todolist_demo/ui/components/todo_tile.dart';

class TodosPage extends StatefulWidget {
  const TodosPage({super.key});

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("todo page build");
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) => Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Wrap(children: const [AddTaskModalBottomSheet()]),
          ),
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
                  child: Consumer<TodoProvider>(
                    builder: (context, data, _) {
                      final todos = data.allTodos
                          .where((element) =>
                              !element.isComplete && !element.toBeDeleted)
                          .toList();
                      return Visibility(
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
                          itemBuilder: (context, index) => TodoTile(
                            todo: todos[index],
                            provider: data,
                          ),
                        ),
                      );
                    },
                  )

                  // child: Visibility(
                  //   visible: todos.isNotEmpty,
                  //   replacement: const Center(
                  //     child: Text(
                  //       "You have no tasks",
                  //       style: TextStyle(letterSpacing: 0.1),
                  //     ),
                  //   ),
                  //   child: ListView.builder(
                  //       shrinkWrap: true,
                  //       itemCount: todos.length,
                  //       itemBuilder: (context, index) =>
                  //           TodoTile(todo: todos[index])),
                  // ),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
