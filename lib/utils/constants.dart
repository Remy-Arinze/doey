import 'package:flutter/material.dart';

PreferredSizeWidget kAppbar(title) {
  return AppBar(
    title: Text(
      title,
    ),
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
  );
}

const kAccentColor = Color(0xff4361ee);

const urgentColor = Colors.red;
const importantColor = Colors.yellow;
