// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:doey/utils/constants.dart';
import 'package:doey/widgets/Global/constants.dart';
import 'package:flutter/material.dart';
import 'package:doey/widgets/Input/TextBox.dart';

class modalContainer extends StatefulWidget {
  TextEditingController controller;
  var todoList;
  var time;
  var index;
  var reshuffleList;
  var addTodo;
  var updateFlag;
  var updateDateTime;
  var updateTodo;
  modalContainer({
    required this.controller,
    this.todoList,
    this.time,
    this.reshuffleList,
    this.index,
    this.updateDateTime,
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
  Color colorToday = kAccentBtn;
  Color colorTommorow = kAccentBtn;
  Color textColorImportant = Colors.black;
  Color textColorUrgent = Colors.black;
  Color todayTextColor = Colors.black;
  Color tomorrowTextColor = Colors.black;

  var selectedDate;

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
          textColorUrgent = Colors.white;
          textColorImportant = Colors.black;
        });
      } else {
        setState(() {
          widget.updateFlag('Normal');
          colorUrgent = kAccentBtn;
          textColorUrgent = Colors.black;
        });
      }
    }
    if (btnValue == 'Important') {
      if (colorImportant == kAccentBtn) {
        widget.updateFlag('Important');

        setState(() {
          colorImportant = Color.fromARGB(255, 194, 97, 0);
          colorUrgent = kAccentBtn;
          textColorUrgent = Colors.black;
          textColorImportant = Colors.white;
        });
      } else {
        setState(() {
          widget.updateFlag('Normal');

          colorImportant = kAccentBtn;
        });
      }
    }

    if (btnValue == 'Today') {
      if (colorToday == kAccentBtn) {
        selectedDate = DateUtils.dateOnly(DateTime.now()).toIso8601String();
        print(selectedDate);
        widget.updateDateTime(selectedDate);
        setState(() {
          colorToday = kPrimaryColor;
          colorTommorow = kAccentBtn;
          todayTextColor = Colors.white;
          tomorrowTextColor = Colors.black;
        });
      }
    }
    if (btnValue == 'Tomorrow') {
      selectedDate = DateUtils.dateOnly(DateTime.now())
          .add(Duration(days: 1))
          .toIso8601String();
      widget.updateDateTime(selectedDate);
      if (colorTommorow == kAccentBtn) {
        setState(() {
          colorToday = kAccentBtn;
          colorTommorow = kPrimaryColor;
          todayTextColor = Colors.black;
          tomorrowTextColor = Colors.white;
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
      backgroundColor: Color.fromARGB(255, 244, 244, 244),
      child: Container(
        padding: EdgeInsets.only(
          right: 10,
          left: 10,
          top: 30,
        ),
        height: MediaQuery.of(context).size.height * 0.35,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: Column(children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Column(children: [
              TextBox(hint: 'Add todo', controller: widget.controller),
            ]),
          ),
          SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'flags :',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(width: 20),
              selectButton(
                  width: 68.0,
                  title: 'Urgent',
                  textColor: textColorUrgent,
                  color: colorUrgent),
              SizedBox(width: 18),
              selectButton(
                  width: 80.0,
                  title: 'Important',
                  textColor: textColorImportant,
                  color: colorImportant),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text('Time', style: TextStyle(color: Colors.grey)),
              SizedBox(width: 20),
              selectButton(
                  title: 'Today', color: colorToday, textColor: todayTextColor),
              SizedBox(width: 20),
              selectButton(
                  title: 'Tomorrow',
                  color: colorTommorow,
                  textColor: tomorrowTextColor),
              SizedBox(width: 20),
              IconButton(
                  onPressed: () async {
                    DateTime? pickDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2005),
                        lastDate: DateTime(2100));

                    if (pickDate != null) {
                      setState(() {
                        selectedDate = pickDate.toIso8601String();
                        widget.updateDateTime(selectedDate);
                      });
                    } else {}
                  },
                  icon: Icon(
                    Icons.calendar_month,
                  ))
            ],
          ),
          SizedBox(
            height: 25,
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
                    widget.reshuffleList(widget.index);
                    Navigator.pop(context);
                  }
                } else {
                  widget.updateTodo(widget.index);
                  widget.reshuffleList(widget.index);

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

  Widget selectButton({
    String title = '',
    Color textColor = Colors.black,
    color,
    width,
  }) {
    return SizedBox(
      width: width,
      height: 20.0,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
        ),
        onPressed: () {
          selectButtons(title);
        },
        child: Text(
          title,
          style: TextStyle(color: textColor, fontSize: 10),
        ),
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
