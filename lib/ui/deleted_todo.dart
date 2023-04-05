import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_demo/blocs/todo_bloc.dart';
import 'package:todolist_demo/cubit/todo/todo_cubit.dart';
import 'package:todolist_demo/models/todo.dart';
import 'package:todolist_demo/ui/components/todo_tile.dart';

class DeletedTodosPage extends StatefulWidget {
  const DeletedTodosPage({super.key});

  @override
  State<DeletedTodosPage> createState() => _DeletedTodosPageState();
}

class _DeletedTodosPageState extends State<DeletedTodosPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("delete page build");

    return BlocSelector<TodoBloc, TodoState, List<Todo>>(
        selector: (state) => state.deletedTodos,
        builder: (context, deletedTodos) {
          return Visibility(
            replacement:
                const Center(child: Text("You have not deleted any tasks")),
            visible: deletedTodos.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: deletedTodos.length,
                    itemBuilder: (context, index) => TodoTile(
                      parent: "Deleted",
                      todo: deletedTodos[index],
                    ),
                  ),
                ),
              ]),
            ),
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
