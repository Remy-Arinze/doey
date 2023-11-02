// ignore_for_file: prefer_const_constructors

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

  Widget isTodoOverdue(i) {
    if (Moment(DateTime.parse(todos['date'])) < Moment(DateTime.now().date)) {
      isOverdue(index);
      return Text(
        'Overdue',
        style: TextStyle(fontSize: 10, color: Colors.red),
      );
    }

    return SizedBox();
  }

  Widget formatDate() {
    if (Moment(DateTime.parse(todos['date'])) == Moment(DateTime.now().date)) {
      return Text(
        'Today',
        style: TextStyle(fontSize: 12),
      );
    } else if (Moment(DateTime.parse(todos['date'])) ==
        Moment(DateTime.now().add(Duration(days: 1)).date)) {
      return Text(
        'Tommorow',
        style: TextStyle(fontSize: 12),
      );
    }
    return Text(
      '${Moment(DateTime.parse(todos['date'])).LL}',
      style: TextStyle(fontSize: 12),
    );
  }

  Widget checktag(tag) {
    if (tag == 'Important') {
      return Text(
        '#important',
        style: TextStyle(
            color: const Color.fromARGB(255, 197, 178, 8), fontSize: 10),
      );
    } else if (tag == 'Urgent') {
      return Text(
        '#Urgent',
        style: TextStyle(color: Colors.red, fontSize: 10),
      );
    } else {
      return SizedBox();
    }
  }

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
          margin: EdgeInsets.symmetric(vertical: 10),
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
              formatDate(),
              SizedBox(width: 5),
              isTodoOverdue(index)
            ]),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 20,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.purple,
                  ),
                ),
                checktag(tag)
              ],
            ),
          ),
        ));
  }
}
