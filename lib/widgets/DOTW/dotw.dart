// ignore_for_file: prefer_const_constructors

import 'package:doey/utils/utilityFunctions.dart';
import 'package:doey/widgets/Global/constants.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class DOTW extends StatefulWidget {
  List dates;
  var func;
  DOTW({super.key, required this.dates, this.func});

  @override
  State<DOTW> createState() => _DOTWState();
}

class _DOTWState extends State<DOTW> {
  List dates = [];

  List<Widget> renderDates(func) {
    List<Widget> dayDates = [];
    for (var i = 0; i < dates.length; i++) {
      final widget = DateTimeLine(
        date: dates[i]['date'].toString(),
        day: dates[i]['day'],
        func: func,
      );

      dayDates.add(widget);
    }
    return dayDates;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dates = widget.dates;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: renderDates(widget.func),
    );
  }
}

class DateTimeLine extends StatefulWidget {
  int day;
  var func;
  String date;
  DateTimeLine({
    super.key,
    required this.day,
    required this.date,
    this.func,
  });

  @override
  State<DateTimeLine> createState() => _DateTimeLineState();
}

class _DateTimeLineState extends State<DateTimeLine> {
  var currentDay = DateTime.now().weekday;
  var changeColor = Colors.black;
  var previousColor = kAccentBtn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Todo: Make days static
    return InkWell(
      onTap: () {
        currentDay = 1;
        currentDay = widget.day;
        widget.func(widget.date);
      },
      child: Container(
        height: currentDay == widget.day ? 42 : 40,
        width: currentDay == widget.day ? 35 : 33,
        margin: EdgeInsets.symmetric(horizontal: 11),
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
            color: currentDay == widget.day ? changeColor : kAccentBtn,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              checkDay(widget.day,
                  currentDay == widget.day ? Colors.white : Colors.black),
              currentDay == widget.day
                  ? Icon(
                      HeroIcons.check_badge,
                      size: 18,
                      color: Colors.white,
                    )
                  : Text(
                      widget.date,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: currentDay == widget.day
                              ? Colors.white
                              : kPrimaryColor,
                          fontSize: 10),
                    ),
            ]),
      ),
    );
  }
}
