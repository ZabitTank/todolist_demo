import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todolist_demo/cubit/todo/todo_cubit.dart';
import 'package:todolist_demo/models/todo.dart';
import 'package:todolist_demo/ui/components/todo_tile.dart';

class SearchResultsPage extends StatelessWidget {
  final String task;
  const SearchResultsPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    print("Search page build");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: RichText(
          text: TextSpan(
            text: "Showing search results for: ",
            children: [
              TextSpan(
                text: task,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            BlocSelector<TodoCubit, TodoState, List<Todo>>(
                selector: (state) => state.getSearchResults(task),
                builder: (context, value) {
                  return Visibility(
                    replacement: Center(
                      child: Text("${value.length} items found"),
                    ),
                    visible: value.isNotEmpty,
                    child: Expanded(
                      child: ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (context, index) =>
                            TodoTile(todo: value[index], parent: "search"),
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
