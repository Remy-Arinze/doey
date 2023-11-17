// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';
import 'dart:math';

import 'package:doey/widgets/Global/constants.dart';
import 'package:flutter/material.dart';

class CountDown extends StatefulWidget {
  int hours;
  int mins;
  CountDown({super.key, required this.hours, required this.mins});

  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  Timer? timer;
  bool isPaused = false;
  int secs = 0;
  startCountDown() {
    setState(() {
      secs = 60;
    });

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          secs--;
          if (secs == 0 && widget.mins > 0) {
            secs = 60;
            widget.mins = widget.mins - 1;
            print(widget.mins);
          } else if (widget.mins == 0 && widget.hours > 0) {
            secs = 60;
            widget.hours = widget.hours - 1;
          } else if (widget.mins == 0 && widget.hours == 0) {
            secs = 0;
            pauseCountDown();
          }
        });
      }
    });
  }

  pauseCountDown() {
    if (timer!.isActive) {
      timer!.cancel();
      setState(() {
        isPaused = true;
      });
    } else if (!timer!.isActive) {
      startCountDown();
      setState(() {
        isPaused = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      startCountDown();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('focus'),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(alignment: Alignment.center, children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.52,
                height: MediaQuery.of(context).size.height * 0.25,
                child: CircularProgressIndicator(
                  value: secs / (60 * widget.mins) + 0.5,
                  backgroundColor: kAccentBtn,
                  color: kPrimaryColor,
                  strokeWidth: 15,
                ),
              ),
              Text(
                '${widget.hours.toString().padLeft(2, '0')}:${widget.mins < 10 ? widget.mins.toString().padLeft(2, '0') : widget.mins}:${secs < 10 ? secs.toString().padLeft(2, '0') : secs}',
                style: TextStyle(fontSize: 35),
              )
            ]),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                pauseCountDown();
              },
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 50)),
                  backgroundColor: MaterialStateProperty.all(Colors.black)),
              child: Text(isPaused ? 'Resume' : 'Pause'),
            )
          ],
        ),
      ),
    );
  }
}
