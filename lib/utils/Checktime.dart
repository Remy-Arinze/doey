import 'package:flutter/material.dart';

Widget timeOfDay(User) {
  final currentTime = TimeOfDay.now();

  if (currentTime.hour >= 1 && currentTime.hour < 12) {
    return Text(
      'Good Morning ${User}!',
      style: TextStyle(
          color: Colors.black, fontSize: 22, fontWeight: FontWeight.w700),
    );
  } else if (currentTime.hour >= 12 && currentTime.hour < 17) {
    return Text(
      'Good Afternoon ${User}!',
      style: TextStyle(
          color: Colors.black, fontSize: 22, fontWeight: FontWeight.w700),
    );
  } else {
    return Text(
      'Good Evening ${User}!',
      style: TextStyle(
          color: Colors.black, fontSize: 22, fontWeight: FontWeight.w700),
    );
  }

  return Container();
}
