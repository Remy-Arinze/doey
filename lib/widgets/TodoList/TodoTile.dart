// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:doey/Adapters/Links.dart';
import 'package:doey/utils/utilityFunctions.dart';
import 'package:doey/widgets/Global/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:moment_dart/moment_dart.dart';

class TodoTile extends StatefulWidget {
  var isDone;
  var archiveTodos;

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
  State<TodoTile> createState() => _TodoTileState();
}

var doneBox = Hive.box('Links');
List doneTodos = [];

class _TodoTileState extends State<TodoTile> {
  checkBox() {
    if (widget.isDone) {
      return IconButton(
          onPressed: () async {
            await widget.changeValue(widget.todos, false);

            await doneTodos.remove(widget.todos);
            await doneBox.put('DoneTodos', Links(doneTodos, false));

            setState(() {});
          },
          icon: Icon(
            HeroIcons.check_badge,
            color: Colors.green,
          ));
    } else {
      return Checkbox(
        value: widget.isDone,
        side: BorderSide(color: kPrimaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        onChanged: (value) {
          widget.changeValue(widget.todos, value);
          doneTodos.add(widget.todos);
          doneBox.put('DoneTodos', Links(doneTodos, false));
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Todo: Make tile non deletable on false click

    return Slidable(
        startActionPane:
            ActionPane(extentRatio: 0.2, motion: DrawerMotion(), children: [
          SlidableAction(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            onPressed: (context) {
              widget.archiveTodos(widget.todos, widget.index);
            },
            icon: Icons.archive_outlined,
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          )
        ]),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            leading: checkBox(),
            title: Text(
              widget.todos['title'],
              overflow: TextOverflow.clip,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  decoration:
                      widget.isDone ? TextDecoration.lineThrough : null),
            ),
            subtitle:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              formatDate(todos: widget.todos, ctx: context),
              widget.label != ''
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
                          widget.label,
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
                  label: widget.label,
                ),
                checktag(widget.tag)
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

  changeColor() {
    if (label == 'Study') {
      return Color(0xFFFF0000);
    } else if (label == 'Personal') {
      return Color(0xFFFF00FF);
    } else if (label == 'Work') {
      return Color(0xFF1a412d);
    } else if (label == 'Habit') {
      return Color(0xFF000000);
    } else if (label == 'Recipe') {
      return Color(0xFF00FFFF);
    } else if (label == 'Exercise') {
      return Color(0xFFFFD700);
    } else if (label == 'Study') {}
  }

  checkLabel() {
    if (label != 'Study' &&
        label != 'Work' &&
        label != 'Habit' &&
        label != 'Personal' &&
        label != 'Exercise' &&
        label != 'Recipe') {
      return SizedBox();
    } else {
      return Container(
        constraints: BoxConstraints(
            maxWidth:
                label != 'Personal' && label != 'Exercise' && label != 'Recipe'
                    ? 40
                    : 55),
        height: 20,
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: changeColor(),
        ),
        child: Center(
          child: Flexible(
            child: Text(
              label,
              style: TextStyle(
                  color: label == 'Recipe'
                      ? Color.fromARGB(255, 96, 96, 96)
                      : Colors.white,
                  fontSize: 10),
            ),
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
