import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_demo/blocs/todo/todo_bloc.dart';
import 'package:todolist_demo/cubit/todo/todo_cubit.dart';
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
                child: BlocBuilder<TodoBloc, TodoState>(
                  builder: (context, state) {
                    final data = state.allTodos
                        .where((element) => !element.toBeDeleted)
                        .toList();
                    return Visibility(
                      visible: data.isNotEmpty,
                      replacement: const Center(
                        child: Text(
                          "You have no tasks",
                          style: TextStyle(letterSpacing: 0.1),
                        ),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) => TodoTile(
                          parent: "Todo List",
                          todo: data[index],
                        ),
                      ),
                    );
                  },
                ),
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
