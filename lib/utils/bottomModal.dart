// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:doey/utils/constants.dart';
import 'package:flutter/material.dart';

class modalContainer extends StatefulWidget {
  TextEditingController controller;
  var todoList;
  var index;
  var addTodo;
  var updateFlag;
  var updateTodo;
  modalContainer({
    required this.controller,
    this.todoList,
    this.index,
    this.updateTodo,
    this.updateFlag,
    required this.addTodo,
    Key? key,
  }) : super(key: key);

  @override
  State<modalContainer> createState() => _modalContainerState();
}

class _modalContainerState extends State<modalContainer> {
  Color colorUrgent = Colors.grey;
  Color colorImportant = Colors.grey;

  checkUpdate() {
    if (widget.todoList != null) {
      widget.controller.text = widget.todoList['title'];
      selectButtons(widget.todoList['tag']);
    } else {
      widget.controller.text = '';
    }
  }

  selectButtons(btnValue) {
    if (btnValue == 'Urgent') {
      if (colorUrgent == Colors.grey) {
        widget.updateFlag('Urgent');

        setState(() {
          colorImportant = Colors.grey;
          colorUrgent = Colors.red;
        });
      } else {
        setState(() {
          widget.updateFlag('Normal');

          colorUrgent = Colors.grey;
        });
      }
    } else {
      if (colorImportant == Colors.grey) {
        widget.updateFlag('Important');

        setState(() {
          colorImportant = Colors.yellow;
          colorUrgent = Colors.grey;
        });
      } else {
        setState(() {
          widget.updateFlag('Normal');

          colorImportant = Colors.grey;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 20, left: 20, top: 40, bottom: 100),
      height: 400,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Column(children: [
        TextField(
          controller: widget.controller,
          decoration: InputDecoration(
              hintText: 'Add Todo',
              hintStyle: TextStyle(fontStyle: FontStyle.italic)),
        ),
        SizedBox(height: 50),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      elevation: 0,
                      color: colorUrgent,
                      onPressed: () {
                        selectButtons('Urgent');
                      },
                      child: Text(
                        '#Urgent',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    MaterialButton(
                      color: colorImportant,
                      onPressed: () {
                        selectButtons('Important');
                      },
                      child: Text(
                        '#Important',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ]),
            ),
            IconButton(
                onPressed: () {
                  if (widget.todoList == null) {
                    widget.addTodo();
                    Navigator.pop(context);
                  } else {
                    widget.updateTodo(widget.index);
                    Navigator.pop(context);
                  }
                },
                icon: Icon(
                  Icons.send,
                  size: 40,
                  color: kAccentColor,
                )),
          ],
        )
      ]),
    );
  }
}

class IconWidgget extends StatelessWidget {
  Widget icon;
  IconWidgget({
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () {}, icon: icon);
  }
}
