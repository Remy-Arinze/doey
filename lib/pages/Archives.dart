import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Archive extends StatefulWidget {
  Archive({super.key});

  @override
  State<Archive> createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  List Archives = [];

  getArchives() async {
    var archive = await Hive.box('Archives');
    Archives = archive.get('archiveList');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getArchives();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Archives'),
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
    );
  }
}
