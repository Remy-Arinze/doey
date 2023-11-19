// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:doey/pages/CountDown.dart';
import 'package:doey/widgets/Global/constants.dart';
import 'package:doey/widgets/Input/TextBox.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class Pomodoro extends StatefulWidget {
  const Pomodoro({super.key});

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  TextEditingController _taskName = TextEditingController();
  TextEditingController _taskDesc = TextEditingController();

  bool isTapped = false;
  int hour = 0;
  int minutes = 0;
  List<bool> isSelected = List.generate(2, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Focus',
          style: TextStyle(color: kPrimaryColor),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'New task',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 15),
          TextBox(hint: 'Task name', controller: _taskName),
          TextBox(hint: 'Description', controller: _taskDesc),
          SizedBox(height: 20),
          TextButton(
              onPressed: () {
                setState(() {
                  isTapped = !isTapped;
                });
              },
              child: Text('Time')),
          isTapped
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      NumberPicker(
                          textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade500),
                          selectedTextStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                          infiniteLoop: true,
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                    color: Colors.grey,
                                  ),
                                  bottom: BorderSide(color: Colors.grey))),
                          minValue: 0,
                          maxValue: 12,
                          value: hour,
                          onChanged: (value) {
                            setState(() {
                              hour = value;
                              print(hour);
                            });
                          }),
                      NumberPicker(
                          textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade500),
                          selectedTextStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                          infiniteLoop: true,
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                    color: Colors.grey,
                                  ),
                                  bottom: BorderSide(color: Colors.grey))),
                          minValue: 0,
                          maxValue: 60,
                          value: minutes,
                          onChanged: (value) {
                            setState(() {
                              minutes = value;
                            });
                          }),
                    ],
                  ),
                )
              : SizedBox(),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => CountDown(
                              hours: hour,
                              mins: minutes,
                              task: _taskName.text,
                            ))));
              },
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 50)),
                  backgroundColor: MaterialStateProperty.all(Colors.black)),
              child: Text('Start'),
            ),
          )
        ]),
      ),
    );
  }

  // NumberPicker NumPicker({timeValue, min, max}) {
  //   return
  // }
}
