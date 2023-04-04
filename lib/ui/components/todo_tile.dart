import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_demo/models/todo.dart';
import 'package:todolist_demo/providers/todo_provider.dart';
import 'package:todolist_demo/ui/todo_page.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;
  const TodoTile({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    print("build todoTile ${todo.title}");
    // final todo = todo;
    final provider = Provider.of<TodoProvider>(context, listen: false);
    return SizedBox(
      height: 90,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => provider.toggleIsComplete(todo),
                child: Icon(
                  todo.isComplete ? Icons.check_circle : Icons.circle_outlined,
                  size: 25,
                ),
              ),
              // const Padding(
              //   padding: EdgeInsets.only(right: 5),
              // ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TodoPage(todo: todo),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 10),
                        child: Text(
                          todo.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Visibility(
                            visible: todo.date != provider.currentDate,
                            child: Text(
                              todo.date.contains(DateTime.now().year.toString())
                                  ? todo.date.replaceAll(
                                      RegExp(", ${DateTime.now().year}"),
                                      todo.time.isNotEmpty ? ", " : "")
                                  : todo.date,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            todo.time,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => provider.toggleToBeDeleted(todo),
                    child: todo.toBeDeleted
                        ? const Icon(
                            Icons.restore,
                            color: Colors.green,
                          )
                        : const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                  ),
                  const Spacer(),
                  Text(
                    todo.category,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
