// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:doey/utils/Checktime.dart';
import 'package:doey/widgets/Global/constants.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:doey/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
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
  String date = '';
  var time = '';
  var User = 'User';
  List todoList = [];

  checkFlag(flag) {
    tag = flag;
  }

  updateDateTime(dt) {
    date = dt;
  }

  selectDate() {}

  doTodo(todoIndex, value) {
    todoIndex['done'] = value;
    setState(() {});
  }

  addTodo() async {
    Map todo = {
      'title': _controller.text,
      'done': false,
      'tag': tag,
      'date': date,
      'time': time
    };
    todoList.add(todo);
    // await myBox.put('todoList', todoList);
    _controller.clear();
    tag = '';
    date = '';
    setState(() {});
  }

  deleteTodos(index) async {
    todoList.removeAt(index);
    await myBox.put('todoList', todoList);
    setState(() {});
  }

  reshuffleOverDueTodos(index) async {
    for (int i = 0; i < todoList.length; i++) {
      if (i == index) {
        final overdueTodo = todoList[i];
        todoList.removeAt(index);
        todoList.insert(0, overdueTodo);
      }
    }
    // await myBox.put('todoList', todoList);
  }

  updateTodos(todoIndex) async {
    Map value = {
      'title': _controller.text,
      'done': false,
      'tag': tag,
      'date': date,
      'time': time
    };
    for (int i = 0; i < todoList.length; i++) {
      if (i == todoIndex) {
        todoList.removeAt(todoIndex);
        todoList.insert(todoIndex, value);
      }
    }
    // await myBox.put('todoList', todoList);
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
    print(name);
    User = name['name'];
    setState(() {});
  }

  getTodos() async {
    var todos = myBox.get('todoList');
    if (todos != null) {
      todoList = todos;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTodos();
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
                Icons.menu,
                color: Colors.black,
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
                      return Container(
                        padding: EdgeInsets.only(left: 5, top: 20),
                        alignment: Alignment.centerLeft,
                        height: 80,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Today ${DateTime.now().toString().substring(0, 10)}',
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            timeOfDay(User),
                          ],
                        ),
                      );
                    }
                    if (index == 1) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0, top: 40),
                        child: Text(
                          'Today',
                          style: TextStyle(
                              color: kAccentColor,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                    return GestureDetector(
                      onTap: () {
                        showModal(context, index - 2, todoList[index - 2]);
                      },
                      child: TodoTile(
                          archiveTodos: archiveTodos,
                          index: index - 2,
                          tag: todoList[index - 2]['tag'],
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
            showModal(
              context,
              null,
              null,
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
      drawer: drawerChild(Name: User),
    );
  }

  Future<dynamic> showModal(BuildContext context, index, [todoList]) {
    return showDialog(
        context: context,
        builder: (context) {
          return modalContainer(
            updateTodo: updateTodos,
            updateFlag: checkFlag,
            controller: _controller,
            todoList: todoList,
            index: index,
            updateDateTime: updateDateTime,
            addTodo: addTodo,
          );
        });
  }
}
