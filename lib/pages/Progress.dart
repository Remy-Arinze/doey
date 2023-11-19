// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:doey/utils/constants.dart';
import 'package:doey/widgets/Global/constants.dart';
import 'package:fl_chart/fl_chart.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Today',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
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
            SizedBox(
              height: 200,
              width: 200,
              child: PieChart(
                PieChartData(
                    pieTouchData: PieTouchData(
                        enabled: true,
                        touchCallback: (event, response) {
                          print({event: response});
                        }),
                    centerSpaceRadius: 50,
                    // readss about it in the PieChartData section
                    sections: [
                      PieChartSectionData(
                          radius: 30,
                          badgeWidget: Icon(EvaIcons.person),
                          value: 20,
                          color: Colors.green,
                          showTitle: false,
                          title: 'Personal'),
                      PieChartSectionData(
                          value: 10,
                          badgeWidget: Icon(EvaIcons.edit),
                          color: Colors.blue,
                          showTitle: false,
                          title: 'Study'),
                      PieChartSectionData(
                          value: 5,
                          color: Colors.red,
                          showTitle: true,
                          title: 'Work'),
                      PieChartSectionData(
                          value: 50,
                          color: Colors.yellow,
                          showTitle: true,
                          title: 'Tuesday'),
                    ]),
                swapAnimationDuration: Duration(milliseconds: 150), // Optional
                swapAnimationCurve: Curves.linear, // Optional
              ),
            )
          ]),
          SizedBox(height: 80),
          Text(
            'This week',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
          ),
          SizedBox(height: 30),
          SizedBox(
            height: mediaSize(context).height * 0.4,
            width: mediaSize(context).width,
            child: BarChart(BarChartData(barGroups: [
              BarChartGroupData(x: 1, barRods: [
                BarChartRodData(
                    toY: 7,
                    backDrawRodData: BackgroundBarChartRodData(
                        color: Colors.red, fromY: 2.0)),
              ]),
              BarChartGroupData(x: 3, barRods: [
                BarChartRodData(
                    toY: 5,
                    backDrawRodData: BackgroundBarChartRodData(
                        color: Colors.red, fromY: 2.0)),
              ]),
            ])),
          )
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
