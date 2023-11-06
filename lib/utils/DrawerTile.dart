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

class _DrawerTileState extends State<DrawerTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _fadeAnimation;

  animate() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);

    _controller.addListener(() {
      setState(() {});
    });
    _controller.forward();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animate();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Archive(
                        boxKey: 'Archives',
                        box: 'archiveList',
                        label: widget.isDone ? 'Completed' : 'Archived',
                        appBarTitle: widget.isDone ? 'Completed' : 'Archived',
                      )));
        },
        child: Card(
          color: kPrimaryColor,
          child: ListTile(
            horizontalTitleGap: 1,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 10,
                  child: Text(
                    '3',
                    style: TextStyle(color: kPrimaryColor),
                  ),
                ),
                SizedBox(height: 8),
                Text(widget.title,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
