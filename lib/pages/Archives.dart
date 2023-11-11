import 'package:doey/pages/AddNote.dart';
import 'package:doey/utils/createTodoModal.dart';
import 'package:doey/widgets/Global/constants.dart';
import 'package:doey/widgets/TodoList/TodoTile.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:moment_dart/moment_dart.dart';

class Archive extends StatefulWidget {
  String appBarTitle;
  bool isLinks;
  String label;
  var tagColor;
  var boxKey;
  var box;
  Archive(
      {super.key,
      required this.appBarTitle,
      this.isLinks = false,
      this.label = '',
      this.tagColor,
      this.box,
      this.boxKey});

  @override
  State<Archive> createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  List todos = [];
  List returnedList = [];
  String tag = '';
  String date = Moment(DateTime.now().date).toIso8601String();
  var time = '';

  final _controller = TextEditingController();

  var todoBox;

  checkFlag(flag) {
    tag = flag;
  }

  updateDateTime(dt) {
    date = dt;
  }

  addTodo() async {
    Map todo = {
      'title': _controller.text,
      'done': false,
      'tag': tag,
      'date': date,
      'time': time,
      'label': widget.label,
    };
    todos.add(todo);
    await todoBox.put('todoList', todos);

    _controller.clear();
    tag = '';
    date = '';
    for (var i = 0; i < todos.length; i++) {
      if (todos[i]['title'] == todo['title']) {
        reshuffleOverDueTodos(i);
      }
    }
    setState(() {});
  }

  doTodo(todoIndex, value) {
    todoIndex['done'] = value;
    setState(() {});
  }

  reshuffleOverDueTodos(index) async {
    todos.sort((a, b) => a['date'].compareTo(b['date']));

    await todoBox.put('todoList', todos);
  }

  getTodos() async {
    var t = await todoBox.get(widget.box);

    if (t != null) {
      todos = t;
      setState(() {});
    }
  }

  List shuffleReturnedList() {
    for (var i = 0; i < todos.length; i++) {
      if (todos[i]['label'] == widget.appBarTitle) {
        returnedList.add(todos[i]);
      }
    }

    return returnedList;
  }

  @override
  void initState() {
    super.initState();

    todoBox = Hive.box(widget.boxKey);
    getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, shuffleReturnedList());
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(widget.appBarTitle),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: widget.label != 'Completed' && widget.label != 'Archived'
            ? ListView.builder(
                itemCount: todos.length,
                itemBuilder: ((context, index) {
                  return todos[index]['label'] == widget.label
                      ? TodoTile(
                          isOverdue: reshuffleOverDueTodos,
                          isDone: todos[index]['done'],
                          label: todos[index]['label'],
                          tagColor: widget.tagColor,
                          todos: todos[index])
                      : Container();
                }))
            : ListView.builder(
                itemCount: todos.length,
                itemBuilder: ((context, index) {
                  print('object');
                  return TodoTile(
                      tagColor: widget.tagColor,
                      isDone: todos[index]['done'],
                      todos: todos[index]);
                })),
      ),
      floatingActionButton: widget.isLinks
          ? FloatingActionButton(
              backgroundColor: kPrimaryColor,
              onPressed: () {
                showModal(
                  context,
                  addTodo: addTodo,
                  checkFlag: checkFlag,
                  updateDateTime: updateDateTime,
                  controller: _controller,
                );
              },
              child: const Icon(Icons.add),
            )
          : Container(),
    );
  }
}
