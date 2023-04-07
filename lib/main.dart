import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_demo/blocs/snackbar/snackbar_bloc.dart';
import 'package:todolist_demo/blocs/todo/todo_bloc.dart';
import 'package:todolist_demo/data/repository.dart';
import 'package:todolist_demo/ui/completed_todo.dart';
import 'package:todolist_demo/ui/deleted_todo.dart';
import 'package:todolist_demo/ui/list_todo.dart';

void main() {
  runApp(
    RepositoryProvider(
      create: (context) => Repository(),
      child: BlocProvider(
        create: (context) => SnackBarBloc(),
        child: BlocProvider(
          child: const MyApp(),
          create: (context) => TodoBloc(
            repository: RepositoryProvider.of<Repository>(context),
          )..add(InitTodoEvent()),
        ),
      ),
    ),
  );

  // runApp(RepositoryProvider(
  //   create: (context) => Repository(),
  //   child: MultiBlocProvider(
  //     providers: [
  //       BlocProvider(
  //         create: (context) =>
  //             TodoBloc(repository: RepositoryProvider.of<Repository>(context))
  //               ..add(InitTodoEvent()),
  //       ),
  //       BlocProvider(
  //         create: (context) => SnackBarBloc(),
  //       )
  //     ],
  //     child: const MyApp(),
  //   ),
  // ));
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
                  ),
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
