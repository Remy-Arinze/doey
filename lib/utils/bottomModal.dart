// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:doey/utils/constants.dart';
import 'package:doey/widgets/Global/constants.dart';
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
  Color colorUrgent = kAccentBtn;
  Color colorImportant = kAccentBtn;

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
      if (colorUrgent == kAccentBtn) {
        widget.updateFlag('Urgent');

        setState(() {
          colorImportant = kAccentBtn;
          colorUrgent = Colors.red;
        });
      } else {
        setState(() {
          widget.updateFlag('Normal');
          colorUrgent = kAccentBtn;
        });
      }
    }
    if (btnValue == 'Important') {
      if (colorImportant == kAccentBtn) {
        widget.updateFlag('Important');

        setState(() {
          colorImportant = Colors.yellow;
          colorUrgent = kAccentBtn;
        });
      } else {
        setState(() {
          widget.updateFlag('Normal');

          colorImportant = kAccentBtn;
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
    return Dialog(
      child: Container(
        padding: EdgeInsets.only(
          right: 20,
          left: 20,
          top: 40,
        ),
        height: MediaQuery.of(context).size.height * 0.30,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: Column(children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextField(
              showCursor: true,
              controller: widget.controller,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Add Todo',
                  hintStyle: TextStyle(fontSize: 12)),
            ),
          ),
          SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'flags :',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(width: 20),
              MaterialButton(
                height: 25,
                minWidth: 50,
                elevation: 0,
                color: colorUrgent,
                onPressed: () {
                  selectButtons('Urgent');
                },
                child: Text(
                  '#Urgent',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
              SizedBox(width: 18),
              MaterialButton(
                height: 25,
                minWidth: 50,
                color: colorImportant,
                onPressed: () {
                  selectButtons('Important');
                },
                child: Text(
                  '#Important',
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(
            height: 35,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(kAccentColor),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
              ),
              onPressed: () {
                if (widget.todoList == null) {
                  if (widget.controller.text.isNotEmpty) {
                    widget.addTodo();
                    Navigator.pop(context);
                  }
                } else {
                  widget.updateTodo(widget.index);
                  Navigator.pop(context);
                }
              },
              child: Text(
                'Done',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ]),
      ),
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
