import 'package:flutter/material.dart';

class AddTodolistWidget extends StatefulWidget {
  const AddTodolistWidget({super.key});

  @override
  State<AddTodolistWidget> createState() => _AddTodolistWidgetState();
}

class _AddTodolistWidgetState extends State<AddTodolistWidget> {
  TextEditingController addTodoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextFormField(
          controller: addTodoController,
        ),
        const Text("shit"),
      ],
    );
  }
}
