// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import '../pages/Todos.dart';
import 'DrawerTile.dart';

class drawerChild extends StatefulWidget {
  drawerChild({
    Key? key,
    required this.Name,
  }) : super(key: key);
  final String Name;

  @override
  State<drawerChild> createState() => _drawerChildState();
}

class _drawerChildState extends State<drawerChild> {
  late Uint8List selectedImage;
  var myBox = Hive.box('User');

  Uint8List? imageString;

  updateImage() async {
    var user = await myBox.get('user');
    Map userMap = {'name': user['name'], 'image': selectedImage};
    await myBox.put('user', userMap);
    setState(() {});
    getImage();
  }

  getImage() async {
    var user = await myBox.get('user');
    if (user['image'] != '') {
      imageString = user['image'];
    } else {
      return;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.only(top: 50.0, left: 15, right: 10),
      child: Column(children: [
        Row(
          children: [
            GestureDetector(
              onTap: () async {
                var image = await ImagePicker()
                    .pickImage(source: ImageSource.gallery, imageQuality: 20);
                if (image != null) {
                  var binImage = await image.readAsBytes();
                  selectedImage = binImage;
                  updateImage();
                  print(selectedImage);
                }
              },
              child: imageString == null
                  ? CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person))
                  : Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: MemoryImage(
                                imageString!,
                              ),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(50)),
                    ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.Name,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  DateTime.now().toString().substring(0, 10),
                  style: TextStyle(
                      color: Color.fromARGB(255, 17, 17, 17), fontSize: 12),
                )
              ],
            )
          ],
        ),
        SizedBox(
          height: 50,
        ),
        DrawerTile(
          title: 'Archives',
          icon: Icon(
            Icons.archive,
            size: 15,
          ),
        ),
        DrawerTile(
          title: 'Done',
          icon: Icon(
            Icons.check,
            size: 15,
          ),
        ),
      ]),
    ));
  }
}
