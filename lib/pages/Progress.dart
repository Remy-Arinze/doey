// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:doey/widgets/Global/constants.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Activity Log',
          style: TextStyle(color: kPrimaryColor),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                SizedBox(height: 18),
                Text(
                  'Today',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 15),
                ChartDesc(
                  title: 'All',
                  color: Colors.grey,
                ),
                ChartDesc(
                  title: 'Personal',
                  color: Colors.green,
                ),
                ChartDesc(
                  title: 'Work',
                  color: Colors.red,
                ),
                ChartDesc(
                  title: 'Study',
                  color: Colors.grey,
                ),
              ],
            ),
            Icon(
              EvaIcons.pie_chart_2,
              size: 160,
              color: kPrimaryColor,
            )
          ]),
        ]),
      ),
    );
  }
}

class ChartDesc extends StatelessWidget {
  String title;
  Color color;
  ChartDesc({super.key, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 6,
            backgroundColor: color,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: TextStyle(color: color),
          ),
        ],
      ),
    );
  }
}
