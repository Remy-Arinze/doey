import 'dart:async';
import 'package:doey/pages/SignInScreen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _sizeTween;
  var userBox = Hive.box('User');
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 500,
        ));

    _sizeTween = Tween<double?>(begin: 10, end: 80).animate(_controller);
    _controller.addListener(() {
      setState(() {});
    });
    _controller.forward();
    Timer(const Duration(seconds: 3), checkIn);
  }

  checkIn() async {
    var check = userBox.get('user');
    if (check == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Details()));
    } else {
      Navigator.pushReplacementNamed(context, '/todos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Icon(
          Icons.today_outlined,
          size: _sizeTween.value,
        ),
      )),
    );
  }
}
