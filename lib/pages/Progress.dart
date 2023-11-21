// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:doey/utils/constants.dart';
import 'package:doey/utils/utilityFunctions.dart';
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
    double barWidth = 15;
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
                        enabled: true, touchCallback: (event, response) {}),
                    centerSpaceRadius: 50,
                    // readss about it in the PieChartData section
                    sections: [
                      PieChartSectionData(
                        radius: 30,
                        badgeWidget: Icon(EvaIcons.person),
                        value: 20,
                        color: Colors.green,
                        showTitle: false,
                      ),
                      PieChartSectionData(
                          value: 10,
                          badgeWidget: Icon(Icons.edit),
                          color: Colors.blue,
                          showTitle: false,
                          title: 'Study'),
                      PieChartSectionData(
                        value: 15,
                        color: Colors.red,
                        showTitle: false,
                        badgeWidget: Icon(EvaIcons.file),
                      ),
                      PieChartSectionData(
                        value: 50,
                        color: Colors.yellow,
                        showTitle: true,
                        badgeWidget: Icon(EvaIcons.activity),
                      ),
                    ]),
                swapAnimationDuration: Duration(milliseconds: 150), // Optional
                swapAnimationCurve: Curves.linear, // Optional
              ),
            )
          ]),
          SizedBox(height: 15),
          Divider(
            color: const Color.fromARGB(137, 46, 46, 46),
            height: 4,
          ),
          SizedBox(height: 20),
          Text(
            'This week',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
          ),
          SizedBox(height: 30),
          SizedBox(
            height: mediaSize(context).height * 0.25,
            width: mediaSize(context).width,
            child: BarChart(BarChartData(
                alignment: BarChartAlignment.center,
                titlesData: FlTitlesData(
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: bottomTitle,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: leftTitle,
                        reservedSize: 50),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawHorizontalLine: false,
                  checkToShowHorizontalLine: ((value) => value % 10 == 0),
                ),
                borderData: FlBorderData(
                    show: false,
                    border: Border(
                        left: BorderSide(color: kPrimaryColor),
                        bottom: BorderSide(color: kPrimaryColor))),
                barGroups: [
                  BarChartGroupData(x: 1, barRods: [
                    BarChartRodData(
                      toY: 5,
                      color: Colors.black,
                      width: barWidth,
                    )
                  ]),
                  BarChartGroupData(x: 2, barRods: [
                    BarChartRodData(toY: 3, width: barWidth),
                  ]),
                  BarChartGroupData(x: 3, barRods: [
                    BarChartRodData(
                      width: barWidth,
                      toY: 5,
                    ),
                  ]),
                  BarChartGroupData(x: 4, barRods: [
                    BarChartRodData(toY: 7, width: barWidth),
                  ]),
                  BarChartGroupData(x: 5, barRods: [
                    BarChartRodData(toY: 3, width: barWidth),
                  ]),
                  BarChartGroupData(x: 6, barRods: [
                    BarChartRodData(toY: 2, width: barWidth),
                  ]),
                  BarChartGroupData(x: 7, barRods: [
                    BarChartRodData(toY: 0, width: barWidth),
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
