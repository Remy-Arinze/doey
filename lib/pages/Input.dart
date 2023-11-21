// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:doey/utils/Checktime.dart';
import 'package:doey/utils/constants.dart';
import 'package:doey/widgets/Global/constants.dart';
import 'package:doey/widgets/Input/TextBox.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:moment_dart/moment_dart.dart';

class InputScreen extends StatefulWidget {
  TextEditingController controller;
  var todoList;
  var time;
  var index;
  var addTodo;
  var updateFlag;
  var updateDateTime;
  var updateTodo;
  InputScreen({
    super.key,
    required this.controller,
    this.todoList,
    this.time,
    this.index,
    this.updateDateTime,
    this.updateTodo,
    this.updateFlag,
    required this.addTodo,
  });

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  Color colorUrgent = kAccentBtn;
  Color colorImportant = kAccentBtn;
  Color colorToday = kAccentBtn;
  Color colorTommorow = kAccentBtn;
  Color textColorImportant = Colors.black;
  Color textColorUrgent = Colors.black;
  Color todayTextColor = Colors.black;
  Color tomorrowTextColor = Colors.black;

  var selectedDate;
  var seletedTime;
  selectTime(ctx) {
    seletedTime = TimeOfDay.now().format(ctx);
  }

  String dateString = 'Today';

  getDate() async {
    DateTime? pickDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2005),
        lastDate: DateTime(2100));

    if (pickDate != null) {
      setState(() {
        selectedDate = pickDate.toIso8601String();

        widget.updateDateTime(selectedDate, true);
        if (selectedDate == DateTime.now().date.toIso8601String()) {
          dateString = 'Today';
        } else if (selectedDate ==
            DateTime.now().date.add(Duration(days: 1)).toIso8601String()) {
          dateString = 'Tomorrow';
        } else {
          dateString = '${selectedDate.toString().substring(0, 10)}';
        }
      });
    } else {}
  }

  getTime(ctx) async {
    var time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        confirmText: 'Add time',
        routeSettings: RouteSettings(name: 'Hello'),
        initialEntryMode: TimePickerEntryMode.dialOnly);

    if (time != null) {
      setState(() {
        seletedTime = time.format(ctx);

        widget.updateDateTime(seletedTime, false);
      });
    } else {
      print('null');
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
    // selectTime(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppbar('Details'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Column(
              children: [
                TextBox(hint: 'Add todo', controller: widget.controller),
                Divider(height: 2, color: Colors.grey),
                TextBox(hint: 'Note', controller: widget.controller),
              ],
            ),
          ),
          SizedBox(height: 30),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Column(
              children: [
                DateTImeSelector(
                  title: 'Date',
                  icon: Icons.calendar_month_rounded,
                  iconColor: Colors.red,
                  sub: dateString,
                  func: getDate,
                ),
                Divider(height: 2, color: Colors.grey),
                DateTImeSelector(
                  title: 'Time',
                  icon: EvaIcons.clock,
                  sub: '${seletedTime}',
                  func: () => getTime(context),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Row(
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
          ),
          SizedBox(height: 30),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.recycling_rounded, color: Colors.grey),
                SizedBox(width: 35),
                Text(
                  'Repeat',
                  style: TextStyle(color: kAccentBtn),
                ),
                SizedBox(width: mediaSize(context).width * 0.40),
                Text('Daily >', style: TextStyle(color: Colors.grey.shade600))
              ],
            ),
          ),
          SizedBox(height: 50),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
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

class DateTImeSelector extends StatelessWidget {
  String title;
  String sub;
  IconData icon;
  Color iconColor;
  var func;
  DateTImeSelector(
      {super.key,
      required this.title,
      required this.sub,
      this.func,
      required this.icon,
      this.iconColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        func();
      },
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(title),
        subtitle: Text(
          sub,
          style: TextStyle(color: kPrimaryColor, fontSize: 11),
        ),
      ),
    );
  }
}
