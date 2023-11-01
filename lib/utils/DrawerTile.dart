import 'package:doey/utils/constants.dart';
import 'package:doey/widgets/Global/constants.dart';
import 'package:flutter/material.dart';

import '../pages/Archives.dart';

class DrawerTile extends StatefulWidget {
  String title;
  Color? color;
  Widget icon;
  DrawerTile({
    this.color,
    required this.title,
    required this.icon,
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
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
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
    print({widget.title: widget.color});
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Archive()));
      },
      child: Card(
        color: kLinkColor,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: widget.color != null ? widget.color : Colors.blue,
            radius: 15,
            child: widget.icon,
          ),
          title: Text(widget.title),
        ),
      ),
    );
  }
}
