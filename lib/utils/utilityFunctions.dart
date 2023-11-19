// ignore_for_file: prefer_const_constructors

import 'package:doey/widgets/Global/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:moment_dart/moment_dart.dart';

Widget formatDate({todos}) {
  if (Moment(DateTime.parse(todos['date'])) == Moment(DateTime.now().date)) {
    return const Text(
      'Today',
      style: TextStyle(fontSize: 12),
    );
  } else if (Moment(DateTime.parse(todos['date'])) ==
      Moment(DateTime.now().add(const Duration(days: 1)).date)) {
    return const Text(
      'Tommorow',
      style: TextStyle(fontSize: 12),
    );
  }
  return Text(
    '${Moment(DateTime.parse(todos['date'])).LL}',
    style: const TextStyle(fontSize: 12),
  );
}

Widget isTodoOverdue(i, {isOverdue, todos, index}) {
  if (Moment(DateTime.parse(todos['date'])) < Moment(DateTime.now().date)) {
    isOverdue(index);
    return const Text(
      'Overdue',
      style: TextStyle(
          fontSize: 13, color: Colors.red, fontWeight: FontWeight.w500),
    );
  }

  return const SizedBox();
}

Widget checktag(tag) {
  if (tag == 'Important') {
    return const Text(
      '#important',
      style: TextStyle(color: Color.fromARGB(255, 197, 178, 8), fontSize: 10),
    );
  } else if (tag == 'Urgent') {
    return const Text(
      '#Urgent',
      style: TextStyle(color: Colors.red, fontSize: 10),
    );
  } else {
    return const SizedBox();
  }
}

List getDays() {
  final dates = [];
  // ignore: unused_local_variable
  for (var i = 0; i < 7; i++) {
    final date = DateTime.now().add(Duration(days: i));
    Map weekDay = {'day': date.weekday, 'date': date.day};
    dates.add(weekDay);
  }

  return dates;
}

checkDay(day, color) {
  if (day == 1) {
    return Text(
      'mon',
      style: TextStyle(fontWeight: FontWeight.w400, color: color, fontSize: 10),
    );
  } else if (day == 2) {
    return Text(
      'tue',
      style: TextStyle(fontWeight: FontWeight.w400, color: color, fontSize: 10),
    );
  } else if (day == 3) {
    return Text(
      'wed',
      style: TextStyle(fontWeight: FontWeight.w400, color: color, fontSize: 10),
    );
  } else if (day == 4) {
    return Text(
      'thu',
      style: TextStyle(fontWeight: FontWeight.w400, color: color, fontSize: 10),
    );
  } else if (day == 5) {
    return Text(
      'fri',
      style: TextStyle(fontWeight: FontWeight.w400, color: color, fontSize: 10),
    );
  } else if (day == 6) {
    return Text(
      'sat',
      style: TextStyle(fontWeight: FontWeight.w400, color: color, fontSize: 10),
    );
  } else if (day == 7) {
    return Text(
      'sun',
      style: TextStyle(fontWeight: FontWeight.w400, color: color, fontSize: 10),
    );
  }
}

Widget bottomTitle(double value, TitleMeta meta) {
  String text = '';
  switch (value.toInt()) {
    case 0:
      text = 'sun';
      break;

    case 1:
      text = 'mon';
      break;

    case 2:
      text = 'tues';
      break;

    case 4:
      text = 'wed';
      break;

    case 5:
      text = 'thu';
      break;

    case 6:
      text = 'fri';
      break;

    case 7:
      text = 'sat';
      break;
  }

  return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Text(
          text,
          style: TextStyle(),
        ),
      ));
}

Widget leftTitle(double value, TitleMeta meta) {
  String text = '';
  switch (value.toInt()) {
    case 0:
      text = '10';
      break;

    case 1:
      text = '20';
      break;

    case 2:
      text = '30';
      break;

    case 4:
      text = '50%';
      break;

    case 5:
      text = '70%';
      break;

    case 6:
      text = '80%';
      break;

    case 7:
      text = '100%';
      break;
  }

  return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        text,
        style: TextStyle(),
      ));
}
