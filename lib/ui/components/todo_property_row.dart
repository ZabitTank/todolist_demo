import 'package:flutter/material.dart';
import 'package:todolist_demo/ui/components/delete_button.dart';

class TodoPropertyRow extends StatelessWidget {
  final String property;
  final Function onDelete;
  const TodoPropertyRow(
      {super.key, required this.property, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: property.isNotEmpty,
      child: Row(
        children: [
          Text(
            property,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const Padding(padding: EdgeInsets.only(left: 5)),
          Align(
            alignment: Alignment.topRight,
            child: DeleteButton(onTap: () {
              onDelete.call();
            }),
          )
        ],
      ),
    );
  }
}
