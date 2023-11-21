// ignore_for_file: sort_child_properties_last

import 'package:doey/utils/constants.dart';
import 'package:doey/widgets/Global/constants.dart';
import 'package:flutter/material.dart';

import '../pages/Archives.dart';

class DrawerTile extends StatefulWidget {
  String title;
  Color? color;
  bool isDone;
  Widget icon;
  DrawerTile({
    this.color,
    required this.title,
    required this.icon,
    required this.isDone,
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerTile> createState() => _DrawerTileState();
}

class _DrawerTileState extends State<DrawerTile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Archive(
                      boxKey: widget.isDone ? 'Links' : 'Archives',
                      box: widget.isDone ? 'DoneTodos' : 'archiveList',
                      label: widget.isDone ? 'Completed' : 'Archived',
                      appBarTitle: widget.isDone ? 'Completed' : 'Archived',
                    )));
      },
      child: Container(
        width: mediaSize(context).width * 0.33,
        height: 40,
        child: Center(
          child: Text(widget.title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500)),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.black,
        ),
      ),
    );
  }
}
