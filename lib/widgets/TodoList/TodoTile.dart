// ignore_for_file: prefer_const_constructors

import 'package:doey/utils/utilityFunctions.dart';
import 'package:doey/widgets/Global/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:moment_dart/moment_dart.dart';

class TodoTile extends StatelessWidget {
  final isDone;
  var archiveTodos;
  var isOverdue;
  var index;
  var tag;
  var changeValue;
  var deleteTodos;
  TodoTile({
    this.index,
    this.tag,
    this.isOverdue = false,
    required this.isDone,
    this.deleteTodos,
    this.changeValue,
    this.archiveTodos,
    Key? key,
    required this.todos,
  }) : super(key: key);

  final todos;

  @override
  Widget build(BuildContext context) {
    return Slidable(
        startActionPane:
            ActionPane(extentRatio: 0.2, motion: DrawerMotion(), children: [
          SlidableAction(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            onPressed: (context) {
              archiveTodos(todos, index);
            },
            icon: Icons.archive_outlined,
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          )
        ]),
        endActionPane:
            ActionPane(extentRatio: 0.2, motion: DrawerMotion(), children: [
          SlidableAction(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            onPressed: (context) {
              deleteTodos(index);
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
          )
        ]),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            leading: Checkbox(
              value: isDone,
              side: BorderSide(color: kPrimaryColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              onChanged: (value) {
                changeValue(todos, value);
              },
            ),
            title: Text(
              todos['title'],
              overflow: TextOverflow.clip,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  decoration: isDone ? TextDecoration.lineThrough : null),
            ),
            subtitle: Row(children: [
              formatDate(todos: todos),
              SizedBox(width: 5),
              isTodoOverdue(index,
                  todos: todos, index: index, isOverdue: isOverdue)
            ]),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [TodoLabel(), checktag(tag)],
            ),
          ),
        ));
  }
}

class TodoLabel extends StatelessWidget {
  const TodoLabel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 30, maxWidth: 40),
      height: 20,
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.purple,
      ),
      child: Flexible(
        child: Center(
          child: Text(
            'Study',
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
        ),
      ),
    );
  }
}
