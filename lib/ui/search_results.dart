import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_demo/models/todo.dart';
import 'package:todolist_demo/providers/todo_provider.dart';
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
            Consumer<TodoProvider>(builder: (context, value, child) {
              List<Todo> searchResults = value.getSearchResults(task);

              return Visibility(
                replacement: Center(
                  child: Text("${searchResults.length} items found"),
                ),
                visible: searchResults.isNotEmpty,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) =>
                        TodoTile(todo: searchResults[index], parent: "search"),
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
