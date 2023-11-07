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
