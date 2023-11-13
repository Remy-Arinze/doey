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
  var currentDate = DateTime.now().day.toString();

  @override
  Widget build(BuildContext context) {
    // Todo: Make days static
    return InkWell(
      onTap: () {
        setState(() {
          currentDate = widget.date;
        });
        widget.func(widget.date);
      },
      child: Container(
        height: currentDate == widget.date ? 42 : 40,
        width: currentDate == widget.date ? 35 : 33,
        margin: EdgeInsets.symmetric(horizontal: 11),
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
            color: currentDate == widget.date ? Colors.blueGrey : kAccentBtn,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              checkDay(widget.day,
                  currentDate == widget.date ? Colors.white : Colors.black),
              currentDate == widget.date
                  ? Icon(
                      HeroIcons.check_badge,
                      size: 18,
                      color: Colors.white,
                    )
                  : Text(
                      widget.date,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: currentDate == widget.date
                              ? Colors.white
                              : kPrimaryColor,
                          fontSize: 10),
                    ),
            ]),
      ),
    );
  }
}
