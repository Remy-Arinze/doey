// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'dart:async';

import 'package:doey/utils/Checktime.dart';
import 'package:doey/utils/createTodoModal.dart';
import 'package:doey/utils/utilityFunctions.dart';
import 'package:doey/widgets/DOTW/dotw.dart';
import 'package:doey/widgets/Global/constants.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:doey/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:moment_dart/moment_dart.dart';
import '../utils/DrawerChild.dart';
import '../utils/bottomModal.dart';
import '../widgets/TodoList/TodoTile.dart';

class Todos extends StatefulWidget {
  const Todos({super.key});

  @override
  State<Todos> createState() => _TodosState();
}

class _TodosState extends State<Todos> {
  final _controller = TextEditingController();
  final _advancedDrawerController = AdvancedDrawerController();
  final myBox = Hive.box('Todos');
  var archiveBox = Hive.box('Archives');
  var userBox = Hive.box('User');

  String tag = '';
  String date = Moment(DateTime.now().date).toIso8601String();
  var time = '';
  String label = '';
  var User = 'User';
  List todoList = [];
  List dates = [];

  checkFlag(flag) {
    tag = flag;
  }

  updateDateTime(dt) {
    date = dt;
  }

  selectDate() {}

  doTodo(todoIndex, value) {
    todoIndex['done'] = value;
    Timer? timer;

    setState(() {
      if (value) {
        timer = Timer(
            Duration(
              seconds: 5,
            ), () async {
          for (int i = 0; i < todoIndex.length; i++) {
            if (todoList[i] == todoIndex) {
              todoList.remove(todoList[i]);
              await myBox.put('todoList', todoList);
              setState(() {});
              return;
            }
          }
        });
      }
      if (timer != null) {
        print('timer not null');
        timer!.cancel();
      }
      return;
    });
  }

  addTodo() async {
    Map todo = {
      'title': _controller.text,
      'done': false,
      'tag': tag,
      'date': date,
      'time': time,
      'label': label,
    };
    todoList.add(todo);
    await myBox.put('todoList', todoList);

    _controller.clear();
    tag = '';
    date = '';
    for (var i = 0; i < todoList.length; i++) {
      if (todoList[i]['title'] == todo['title']) {
        reshuffleOverDueTodos(i);
      }
    }

    setState(() {});
  }

  deleteTodos(index) async {
    todoList.removeAt(index);
    await myBox.put('todoList', todoList);
    setState(() {});
  }

  reshuffleOverDueTodos(index) async {
    todoList.sort((a, b) => a['date'].compareTo(b['date']));

    await myBox.put('todoList', todoList);
  }

  updateTodos(todoIndex) async {
    Map value = {
      'title': _controller.text,
      'done': false,
      'tag': tag,
      'date': date,
      'time': time,
      'label': label,
    };
    for (int i = 0; i < todoList.length; i++) {
      if (i == todoIndex) {
        todoList.removeAt(todoIndex);
        todoList.insert(todoIndex, value);
      }
    }
    await myBox.put('todoList', todoList);
    reshuffleOverDueTodos(todoIndex);
    _controller.clear();
    tag = '';
    date = '';
    setState(() {});
  }

  _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  archiveTodos(todoIndex, [index]) async {
    if (todoIndex['done']) {
      List archives = [];
      archives.add(todoIndex);
      await archiveBox.put('archiveList', archives);
      List upDatedBox = await myBox.get('todoList');
      upDatedBox.removeAt(index);
      await myBox.put('todoList', upDatedBox);

      setState(() {});
    } else {
      print('Task is not done');

      SnackBar snackar = SnackBar(
          margin: EdgeInsets.only(right: 20, left: 20),
          behavior: SnackBarBehavior.floating,
          dismissDirection: DismissDirection.startToEnd,
          duration: Duration(milliseconds: 1500),
          elevation: 1,
          content: Container(
            child: Text(
              'Task is not done',
              style: TextStyle(color: Colors.white),
            ),
          ));

      ScaffoldMessenger.of(context).showSnackBar(snackar);
    }
  }

  getDetails() async {
    var name = await userBox.get('user');
    User = name['name'];
    setState(() {});
  }

  getTodos(date) async {
    var todos = myBox.get('todoList');
    var isToday = false;
    List newTodos = [];
    List todaysTodos = [];
    if (todos != null) {
      for (var i = 0; i < todos.length; i++) {
        if (date == DateTime.parse(todos[i]['date']).day.toString() &&
            date != DateTime.now().day.toString()) {
          isToday = false;
          newTodos = [];
          newTodos.add(todos[i]);
        } else if (date == DateTime.parse(todos[i]['date']).day.toString() ||
            date == DateTime.now().day.toString()) {
          isToday = true;
          todaysTodos.add(todos[i]);
        }
      }
      if (newTodos != null && isToday) {
        todoList = todaysTodos;
        setState(() {});
      } else {
        todoList = newTodos;
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getTodos(DateTime.now().day.toString());
    dates = getDays();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: kBackgroundColor,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Scaffold(
        backgroundColor: kAccentColor,
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          leading: IconButton(
              onPressed: () {
                _handleMenuButtonPressed();
              },
              icon: Icon(
                EvaIcons.grid_outline,
                color: kPrimaryColor,
              )),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: kBackgroundColor,
          ),
          padding: const EdgeInsets.only(top: 10.0, right: 20, left: 20),
          child: todoList.isEmpty
              ? Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add),
                      Text('You have no todos '),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: todoList.length + 2,
                  itemBuilder: ((context, index) {
                    if (index == 0) {
                      return Padding(
                          padding: const EdgeInsets.only(bottom: 30.0, top: 5),
                          child: DOTW(
                            dates: dates,
                            func: getTodos,
                          ));
                    }
                    if (index == 1) {
                      return Container(
                        padding: EdgeInsets.only(
                          left: 5,
                          top: 5,
                        ),
                        alignment: Alignment.centerLeft,
                        height: 55,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Today ${DateTime.now().toString().substring(0, 10)}',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.blueGrey),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            timeOfDay(User),
                          ],
                        ),
                      );
                    }
                    return GestureDetector(
                      onTap: () {
                        showModal(context,
                            index: index - 2,
                            todoList: todoList[index - 2],
                            updateTodos: updateTodos,
                            addTodo: addTodo,
                            updateDateTime: updateDateTime,
                            controller: _controller,
                            checkFlag: checkFlag);
                      },
                      child: TodoTile(
                          archiveTodos: archiveTodos,
                          index: index - 2,
                          tag: todoList[index - 2]['tag'],
                          label: todoList[index - 2]['label'],
                          changeValue: doTodo,
                          isOverdue: reshuffleOverDueTodos,
                          isDone: todoList[index - 2]['done'],
                          deleteTodos: deleteTodos,
                          todos: todoList[index - 2]),
                    );
                  })),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          onPressed: () {
            showModal(context,
                controller: _controller,
                updateDateTime: updateDateTime,
                checkFlag: checkFlag,
                addTodo: addTodo);
          },
          child: const Icon(Icons.add),
        ),
      ),
      drawer: drawerChild(Name: User),
    );
  }
}
