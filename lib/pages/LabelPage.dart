import 'package:doey/utils/createTodoModal.dart';
import 'package:doey/widgets/Global/constants.dart';
import 'package:doey/widgets/TodoList/TodoTile.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:moment_dart/moment_dart.dart';

class LabelPage extends StatefulWidget {
  String appBarTitle;

  var boxKey;

  LabelPage({super.key, required this.appBarTitle, this.boxKey});

  @override
  State<LabelPage> createState() => _LabelPageState();
}

class _LabelPageState extends State<LabelPage> {
  List todos = [];
  String tag = '';
  String date = Moment(DateTime.now().date).toIso8601String();
  var time = '';
  var todoBox = Hive.box('Links');

  final _controller = TextEditingController();

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
      'label': widget.appBarTitle,
    };
    todos.add(todo);
    await todoBox.put('LabelTodos', todos);

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

    await todoBox.put('LabelTodos', todos);
  }

  getTodos() async {
    var t = await todoBox.get('LabelTodos');

    if (t != null) {
      todos = t;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, todos);
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded),
          ),
          title: Text(widget.appBarTitle),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: ((context, index) {
                  return todos[index]['label'] == widget.appBarTitle
                      ? TodoTile(
                          isDone: todos[index]['done'], todos: todos[index])
                      : Container();
                }))),
        floatingActionButton: FloatingActionButton(
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
        ));
  }
}
