// ignore_for_file: prefer_const_constructors

import 'package:doey/utils/utilityFunctions.dart';
import 'package:doey/widgets/Global/constants.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class DOTW extends StatefulWidget {
  const DOTW({super.key});

  @override
  State<DOTW> createState() => _DOTWState();
}

class _DOTWState extends State<DOTW> {
  List dates = [];

  getDays() {
    // ignore: unused_local_variable
    for (var i = 0; i < 7; i++) {
      final date = DateTime.now().add(Duration(days: i));
      Map weekDay = {'day': date.weekday, 'date': date.day};
      dates.add(weekDay);
    }
  }

  List<Widget> renderDates() {
    List<Widget> dayDates = [];
    for (var i = 0; i < dates.length; i++) {
      final widget = DateTimeLine(
        date: dates[i]['date'].toString(),
        day: dates[i]['day'],
      );

      dayDates.add(widget);
    }
    return dayDates;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDays();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: renderDates(),
    );
  }
}

class DateTimeLine extends StatelessWidget {
  int day;
  String date;
  DateTimeLine({super.key, required this.day, required this.date});

  var currentDate = DateTime.now().weekday;

  @override
  Widget build(BuildContext context) {
    print({day: currentDate});
    return Container(
      height: currentDate == day ? 42 : 40,
      width: currentDate == day ? 35 : 33,
      margin: EdgeInsets.symmetric(horizontal: 11),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
          color: currentDate == day ? Colors.blueGrey : kAccentBtn,
          borderRadius: BorderRadius.circular(10)),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        checkDay(day, currentDate == day ? Colors.white : Colors.black),
        currentDate == day
            ? Icon(
                HeroIcons.check_badge,
                size: 18,
                color: Colors.white,
              )
            : Text(
                date,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: currentDate == day ? Colors.white : kPrimaryColor,
                    fontSize: 10),
              ),
      ]),
    );
  }
}
