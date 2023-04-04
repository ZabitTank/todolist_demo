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
    print("complete page build");
    final provider = Provider.of<TodoProvider>(context);
    final List<Todo> completedTodos = provider.completedTodos;

    return Visibility(
      replacement: const Center(
        child: Text("You have not completed any tasks"),
      ),
      visible: completedTodos.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("${completedTodos.length} Completed"),
          const Divider(),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          Expanded(
            child: ListView.builder(
              itemCount: completedTodos.length,
              itemBuilder: (context, index) => TodoTile(
                provider: provider,
                todo: completedTodos[index],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
