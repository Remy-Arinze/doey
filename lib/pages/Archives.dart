import 'package:doey/widgets/Global/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Archive extends StatefulWidget {
  String appBarTitle;
  bool isLinks;
  Archive({super.key, required this.appBarTitle, this.isLinks = false});

  @override
  State<Archive> createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  List Archives = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarTitle),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
          itemCount: Archives.length,
          itemBuilder: ((context, index) {
            return Card(
              margin: EdgeInsets.only(top: 10, left: 10, right: 10),
              shadowColor: Color.fromARGB(255, 245, 245, 245),
              child: ListTile(
                leading: Checkbox(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  fillColor: MaterialStateProperty.all(Colors.red),
                  onChanged: (value) {},
                  value: Archives[index]['done'],
                ),
                title: Text(
                  Archives[index]['title'],
                  style: TextStyle(
                    decoration: (Archives[index]['done']
                        ? TextDecoration.lineThrough
                        : null),
                  ),
                ),
                trailing: Text('done'),
              ),
            );
          })),
      floatingActionButton: widget.isLinks
          ? FloatingActionButton(
              backgroundColor: kPrimaryColor,
              onPressed: () {},
              child: const Icon(Icons.add),
            )
          : Container(),
    );
  }
}
