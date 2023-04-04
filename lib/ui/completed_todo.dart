import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_demo/models/todo.dart';
import 'package:todolist_demo/providers/todo_provider.dart';
import 'package:todolist_demo/ui/components/todo_tile.dart';

class CompletedTodosPage extends StatefulWidget {
  const CompletedTodosPage({super.key});

  @override
  State<CompletedTodosPage> createState() => _CompletedTodosPageState();
}

class _CompletedTodosPageState extends State<CompletedTodosPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("completed page build");

    return Selector<TodoProvider, List<Todo>>(
      selector: (_, provider) => provider.completedTodos,
      builder: (context, value, child) {
        return Visibility(
          replacement: const Center(
            child: Text("You have not completed any tasks"),
          ),
          visible: value.isNotEmpty,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("${value.length} Completed"),
              const Divider(),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              Expanded(
                child: ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) => TodoTile(
                    todo: value[index],
                    parent: "Completed",
                  ),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
