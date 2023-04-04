import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_demo/providers/todo_provider.dart';
import 'package:todolist_demo/ui/completed_todo.dart';
import 'package:todolist_demo/ui/deleted_todo.dart';
import 'package:todolist_demo/ui/list_todo.dart';

void main() {
  runApp(ChangeNotifierProvider(
    child: const MyApp(),
    create: (context) => TodoProvider(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todolist Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: const Padding(
                padding: EdgeInsets.only(top: 15, bottom: 10),
                child: Text(
                  "Todo Bloc",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.black),
                ),
              ),
              bottom: TabBar(
                indicatorColor: Theme.of(context).primaryColor,
                tabs: const [
                  Tab(
                    text: "Todo",
                  ),
                  Tab(
                    text: "Completed",
                  ),
                  Tab(
                    text: "Deleted",
                  )
                ],
              ),
            ),
            body: const TabBarView(children: [
              TodosPage(),
              CompletedTodosPage(),
              DeletedTodosPage()
            ])),
      ),
    );
  }
}