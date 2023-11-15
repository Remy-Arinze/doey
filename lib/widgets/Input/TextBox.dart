import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  String hint;
  double fontSize;
  TextEditingController controller;
  TextBox({
    required this.hint,
    this.fontSize = 10,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      width: MediaQuery.of(context).size.width,
      child: TextField(
        showCursor: true,
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(fontSize: fontSize)),
      ),
    );
  }
}
