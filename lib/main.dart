// ignore_for_file: prefer_const_constructors

import 'package:doey/pages/AddNote.dart';
import 'package:doey/pages/SplashScreen.dart';
import 'package:doey/pages/Todos.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('TODOS');
  await Hive.openBox('Archives');
  await Hive.openBox('User');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doey',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 249, 249, 249),
          appBarTheme: AppBarTheme(
            elevation: 0,
          )),
      home: SplashScreen(),
      routes: {
        '/addTodo': (context) => AddTodo(),
        '/todos': (context) => Todos(),
      },
    );
  }
}
