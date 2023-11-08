// ignore_for_file: prefer_const_constructors

import 'package:doey/utils/utilityFunctions.dart';
import 'package:doey/widgets/Global/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:moment_dart/moment_dart.dart';

class TodoTile extends StatelessWidget {
  final isDone;
  var archiveTodos;
  var isOverdue;
  var index;
  var tagColor;
  String label;
  var tag;
  var changeValue;
  var deleteTodos;
  TodoTile({
    this.index,
    this.tag,
    this.tagColor,
    this.isOverdue = false,
    required this.isDone,
    this.label = '',
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
            subtitle: Column(children: [
              Row(children: [
                formatDate(todos: todos),
                SizedBox(width: 60),
                isTodoOverdue(index,
                    todos: todos, index: index, isOverdue: isOverdue)
              ]),
              label != ''
                  ? Row(
                      children: [
                        Icon(
                          EvaIcons.folder_outline,
                          size: 14,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          label,
                          style: TextStyle(color: kAccentBtn, fontSize: 10),
                        )
                      ],
                    )
                  : Container()
            ]),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TodoLabel(
                  label: label,
                ),
                checktag(tag)
              ],
            ),
          ),
        ));
  }
}

class TodoLabel extends StatelessWidget {
  String label;
  String color;
  TodoLabel({super.key, this.label = '', this.color = ''});

  checkLabel() {
    if (label != 'Study' &&
        label != 'Work' &&
        label != 'Habit' &&
        label != 'Personal' &&
        label != 'Exercise' &&
        label != 'Recipe') {
      return SizedBox();
    } else {
      print(color);
      return Container(
        constraints: BoxConstraints(maxHeight: 30, maxWidth: 40),
        height: 20,
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.purple,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return checkLabel();
  }
}
