import 'package:flutter/material.dart';

const kAccentBtn = Color.fromARGB(255, 207, 207, 207);
const kLinkColor = Color.fromARGB(255, 144, 172, 255);
const kPrimaryColor = Color(0xff4361ee);
const kBackgroundColor = Color.fromARGB(255, 237, 237, 237);
const kTitleStyle =
    TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.black);

const randomColors = [
  Colors.red,
  Colors.blue,
  Colors.amber,
  Colors.purple,
  Colors.black,
  Colors.green,
  Colors.pink,
  Colors.orange,
  Colors.teal
];

final mockArray = [
  {'name': 'Work', 'color': randomColors[0]},
  {'name': 'Study', 'color': randomColors[8]},
  {'name': 'Exercise', 'color': randomColors[2]},
  {'name': 'Recipe', 'color': randomColors[3]},
  {'name': 'Personal', 'color': randomColors[5]},
  {'name': 'Habit', 'color': randomColors[7]}
];
final projectArray = [
  {'name': 'Doey App', 'tasks': 5, 'icon': 'tag'},
  {'name': 'Web Design', 'tasks': 2, 'icon': 'tag'},
];
