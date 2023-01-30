// ignore_for_file: prefer_const_constructors

import 'package:doey/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final TextEditingController _controller = TextEditingController();
  String errMsg = '';
  registerName() async {
    var userBox = await Hive.box('User');
    if (_controller.text.isNotEmpty) {
      userBox.put('Name', _controller.text);
      Navigator.pushReplacementNamed(context, '/todos');
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
                controller: _controller,
                decoration: InputDecoration(hintText: 'Name'),
              ),
              SizedBox(height: 10),
              errMsg != ''
                  ? Text(
                      errMsg,
                      style: TextStyle(color: Colors.red),
                    )
                  : SizedBox(),
              MaterialButton(
                onPressed: () {
                  registerName();
                },
                splashColor: kAccentColor,
                color: kAccentColor,
                child: Text(
                  'Continue',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
