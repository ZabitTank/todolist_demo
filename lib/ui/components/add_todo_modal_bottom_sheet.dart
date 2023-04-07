import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todolist_demo/blocs/todo/todo_bloc.dart';
import 'package:todolist_demo/models/todo.dart';
import 'package:todolist_demo/ui/categories.dart';
import 'package:todolist_demo/ui/components/todo_property_row.dart';

class AddTaskModalBottomSheet extends StatefulWidget {
  const AddTaskModalBottomSheet({super.key});

  @override
  State<AddTaskModalBottomSheet> createState() {
    return _AddTaskModalBottomSheetState();
  }
}

class _AddTaskModalBottomSheetState extends State<AddTaskModalBottomSheet> {
  String date = "";
  String time = "";
  String category = "";

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("Build Add Todo Modal");
    ThemeData themeData = Theme.of(context).copyWith(
      colorScheme: ColorScheme.light(primary: Theme.of(context).primaryColor),
    );

    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 40, left: 40),
      child: Column(children: [
        TextField(
          controller: titleController,
          decoration: const InputDecoration(
            hintText: "Title",
          ),
          style: const TextStyle(fontSize: 12),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: TextField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: "Description"),
            style: const TextStyle(fontSize: 12),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
            children: [
              IconButton(
                onPressed: () async {
                  await Navigator.of(context)
                      .push(MaterialPageRoute(
                    builder: (context) => CategoryBox(),
                  ))
                      .then((value) {
                    if (value == null) return;
                    setState(() {
                      category = value;
                    });
                  });
                },
                icon: const Icon(Icons.tag),
              ),
              TodoPropertyRow(
                  property: category,
                  onDelete: () {
                    setState(() {
                      category = "";
                    });
                  }),
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: () async {
                  await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2023),
                          lastDate: DateTime(2033),
                          builder: (context, child) =>
                              Theme(data: themeData, child: child!))
                      .then((selectedDate) {
                    if (selectedDate != null) {
                      var formattedDate =
                          DateFormat.yMMMd().format(selectedDate);
                      setState(() {
                        date = formattedDate.toString();
                      });
                    }
                  });
                },
                icon: const Icon(Icons.calendar_month_rounded),
              ),
              TodoPropertyRow(
                property: date,
                onDelete: () {
                  setState(() {
                    date = "";
                  });
                },
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: () async {
                  await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (context, child) =>
                        Theme(data: themeData, child: child!),
                  ).then((selectedTime) {
                    if (selectedTime != null) {
                      setState(() {
                        time = selectedTime.format(context);
                      });
                    }
                  });
                },
                icon: const Icon(Icons.watch_later_outlined),
              ),
              TodoPropertyRow(
                property: time,
                onDelete: () {
                  setState(() {
                    time = "";
                  });
                },
              ),
            ],
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  context.read<TodoBloc>().add(
                        AddTodoEvent(
                          newTodo: Todo(
                              title: titleController.text.trim(),
                              description: descriptionController.text.trim(),
                              date: date,
                              time: time,
                              category: category),
                        ),
                      );
                }
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.add_circle_outline_sharp),
            ),
          )
        ]),
      ]),
    );
  }
}
