import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_demo/blocs/todo/todo_bloc.dart';
import 'package:todolist_demo/cubit/todo/todo_cubit.dart';
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

    return BlocBuilder<TodoBloc, TodoState>(
      buildWhen: (previous, current) =>
          previous.completedTodos != current.completedTodos,
      builder: (context, state) {
        final value = state.completedTodos;
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
