// ignore_for_file: prefer_const_constructors

import 'package:doey/Adapters/Links.dart';
import 'package:doey/pages/Archives.dart';
import 'package:doey/utils/constants.dart';
import 'package:doey/widgets/Global/constants.dart';
import 'package:doey/widgets/Input/PopUp.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import '../pages/Todos.dart';
import 'package:doey/widgets/Input/TextBox.dart';
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
  final TextEditingController _controller = new TextEditingController();
  var myBox = Hive.box('User');
  var LinksBox = Hive.box('Links');
  var projects = [];

  Uint8List? imageString;

  addProject() async {
    Map<dynamic, dynamic> newProject = {
      'title': _controller.text,
      'todoLabel': false,
      'project': true
    };
    projects.add(newProject);
    await LinksBox.put('Projects', Links(projects, true));
    setState(() {});
  }

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

  getProjects() async {
    var project = await LinksBox.get('Projects').todos;
    if (project != null) {
      projects = project;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImage();
    getProjects();
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
                }
              },
              child: imageString == null
                  ? CircleAvatar(
                      radius: 30,
                      backgroundColor: kAccentBtn,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ))
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
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                SizedBox(height: 4),
                Text(
                  DateTime.now().toString().substring(0, 10),
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 12,
                  ),
                )
              ],
            )
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            DrawerTile(
              isDone: true,
              color: kPrimaryColor,
              title: 'Completed',
              icon: Icon(
                Icons.check,
                size: 15,
              ),
            ),
            DrawerTile(
              isDone: false,
              color: kPrimaryColor,
              title: 'Archived',
              icon: Icon(
                Icons.archive,
                size: 15,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Projects', style: kTitleStyle),
            popUp(context,
                controller: _controller, isLabel: false, func: addProject),
          ],
        ),
        SizedBox(height: 5),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              itemCount: projects.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Archive(
                                    label: '${projects[index]['title']}',
                                    boxKey: 'Todos',
                                    box: 'todoList',
                                    isLinks: true,
                                    appBarTitle:
                                        '${projects[index]['title']}')))
                        .then((_) => setState(() {}));
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: ListTile(
                      title: Text(
                        '${projects[index]['title']}',
                        style: TextStyle(color: Colors.black),
                      ),
                      trailing: Text('${projects.length}'),
                    ),
                  ),
                );
              }),
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Labels',
              style: kTitleStyle,
            ),
            popUp(context, controller: _controller),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: GridView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: mockArray.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.8),
              itemBuilder: (context, index) {
                return Center(
                  child: ListTile(
                    horizontalTitleGap: 0,
                    trailing: CircleAvatar(
                        backgroundColor: mockArray[index]['color'] as Color,
                        radius: 10),
                    tileColor: Colors.white,
                    title: Text('${mockArray[index]['name']}'),
                  ),
                );
              }),
        )
      ]),
    ));
  }
}
