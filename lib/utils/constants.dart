import 'package:flutter/material.dart';

PreferredSizeWidget kAppbar(title) {
  return AppBar(
    title: Text(
      title,
    ),
    backgroundColor: Color.fromARGB(255, 249, 249, 249),
    foregroundColor: Colors.black,
  );
}

const kAccentColor = Color(0xff4361ee);

Size mediaSize(ctx) {
  return MediaQuery.of(ctx).size;
}

const urgentColor = Colors.red;
const importantColor = Colors.yellow;
