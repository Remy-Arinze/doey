import 'package:doey/utils/constants.dart';
import 'package:doey/widgets/Global/constants.dart';
import 'package:flutter/material.dart';
import 'package:doey/widgets/Input/TextBox.dart';

IconButton popUp(BuildContext context, {controller, isLabel, func}) {
  return IconButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 0.85,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Column(children: [
                      TextBox(
                        hint: 'title',
                        controller: controller,
                        fontSize: 13,
                      ),
                      SizedBox(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: isLabel
                            ? ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: randomColors.length,
                                itemBuilder: (context, index) {
                                  return Checkbox(
                                    value: false,
                                    side: const BorderSide(
                                        color: Colors.transparent),
                                    fillColor: MaterialStateProperty.all(
                                        randomColors[index]),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    onChanged: (value) {},
                                  );
                                })
                            : SizedBox(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(kAccentColor),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0))),
                          ),
                          onPressed: () {
                            func();
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Done',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ])),
              );
            });
      },
      icon: Icon(Icons.add));
}
