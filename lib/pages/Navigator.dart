import 'package:doey/pages/Progress.dart';
import 'package:doey/pages/Todos.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int current = 0;
  List pages = [
    Todos(),
    ProgressScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[current],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(EvaIcons.home_outline), label: 'Todos'),
          BottomNavigationBarItem(
              icon: Icon(EvaIcons.pie_chart_outline), label: 'Charts')
        ],
        onTap: (value) {
          setState(() {
            current = value;
          });
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: current,
      ),
    );
  }
}
