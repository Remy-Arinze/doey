// ignore_for_file: prefer_const_constructors

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
  int hour = 1;
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
                          minValue: 1,
                          maxValue: 12,
                          value: hour,
                          onChanged: (value) {
                            setState(() {
                              hour = value;
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
                          maxValue: 12,
                          value: minutes,
                          onChanged: (value) {
                            setState(() {
                              minutes = value;
                            });
                          }),
                      ToggleButtons(
                        direction: Axis.vertical,
                        isSelected: isSelected,
                        renderBorder: true,
                        borderWidth: 5,
                        borderColor: Colors.white,
                        onPressed: (int i) {
                          int otherIndex = 0;
                          setState(() {
                            i == 0 ? otherIndex = 1 : 0;
                            isSelected[i] = !isSelected[i];
                            isSelected[otherIndex] = !isSelected[otherIndex];
                            print({i: isSelected[i]});
                            print({otherIndex: isSelected[otherIndex]});
                          });
                        },
                        children: [
                          Container(
                              child: Text(
                            'AM',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                          Container(
                              child: Text('PM',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ))),
                        ],
                      )
                    ],
                  ),
                )
              : SizedBox(),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 50)),
                  backgroundColor: MaterialStateProperty.all(kPrimaryColor)),
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
