// ignore_for_file: prefer_const_constructors

import 'package:doey/Adapters/Links.dart';
import 'package:doey/utils/constants.dart';
import 'package:doey/widgets/Global/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final TextEditingController _controller = TextEditingController();
  var linksBox = Hive.box('Links');

  String errMsg = '';
  final done = [];
  registerName() async {
    Map user = {'name': _controller.text, 'image': ''};
    var userBox = await Hive.box('User');
    if (_controller.text.isNotEmpty) {
      await userBox.put('user', user);
      await linksBox.put('Projects', Links(howToUseDoey, true));
      await linksBox.put('Labels', Links(labels, false));
      await linksBox.put('DoneTodos', Links(done, false));
      Navigator.pushReplacementNamed(context, '/nav');
    } else {
      errMsg = 'Please enter a name';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                showCursor: true,
                controller: _controller,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'What is your name ?',
                    hintStyle: TextStyle(fontSize: 12)),
              ),
              SizedBox(height: 20),
              errMsg != ''
                  ? Text(
                      errMsg,
                      style: TextStyle(color: Colors.red),
                    )
                  : SizedBox(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  onPressed: () {
                    registerName();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kAccentColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0))),
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
