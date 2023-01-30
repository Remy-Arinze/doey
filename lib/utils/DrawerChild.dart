// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../pages/Todos.dart';
import 'DrawerTile.dart';

class drawerChild extends StatelessWidget {
  const drawerChild({
    Key? key,
    required this.Name,
  }) : super(key: key);

  final String Name;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.only(top: 50.0, left: 15, right: 10),
      child: Column(children: [
        Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: Icon(Icons.person),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              Name,
              style: TextStyle(color: Colors.white, fontSize: 20),
            )
          ],
        ),
        SizedBox(
          height: 50,
        ),
        DrawerTile(
          title: 'Archives',
          icon: Icon(
            Icons.archive,
            size: 15,
          ),
        ),
        DrawerTile(
          title: 'Done',
          icon: Icon(
            Icons.check,
            size: 15,
          ),
        ),
      ]),
    ));
  }
}
