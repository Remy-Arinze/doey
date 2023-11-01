// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';

class TodoTile extends StatelessWidget {
  final isDone;
  var archiveTodos;
  var index;
  var tag;
  var changeValue;
  var deleteTodos;
  TodoTile({
    this.index,
    this.tag,
    required this.isDone,
    this.deleteTodos,
    this.changeValue,
    this.archiveTodos,
    Key? key,
    required this.todos,
  }) : super(key: key);

  final todos;

  checktag(tag) {
    if (tag == 'Important') {
      return MaterialStateProperty.all(Colors.yellow);
    } else if (tag == 'Urgent') {
      return MaterialStateProperty.all(Colors.red);
    } else {
      return MaterialStateProperty.all(Colors.grey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane:
          ActionPane(extentRatio: 0.2, motion: DrawerMotion(), children: [
        SlidableAction(
          onPressed: (context) {
            archiveTodos(todos, index);
          },
          icon: Icons.archive_outlined,
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        )
      ]),
      endActionPane:
          ActionPane(extentRatio: 0.3, motion: DrawerMotion(), children: [
        SlidableAction(
          onPressed: (context) {
            deleteTodos(index);
          },
          backgroundColor: Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          icon: Icons.delete,
        )
      ]),
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: ListTile(
          leading: Checkbox(
            fillColor: checktag(tag),
            value: isDone,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60),
                side: BorderSide(width: 2.0, style: BorderStyle.none)),
            onChanged: (value) {
              changeValue(todos, value);
            },
          ),
          title: Text(
            todos['title'],
            style: TextStyle(
                color: Colors.black,
                decoration: isDone ? TextDecoration.lineThrough : null),
          ),
        ),
      ),
    );
  }
}
