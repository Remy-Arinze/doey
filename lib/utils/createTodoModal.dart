import 'package:doey/utils/bottomModal.dart';
import 'package:flutter/material.dart';

Future<dynamic> showModal(BuildContext context,
    {index,
    todoList,
    controller,
    checkFlag,
    updateTodos,
    updateDateTime,
    addTodo}) {
  return showDialog(
      context: context,
      builder: (context) {
        return modalContainer(
          updateTodo: updateTodos,
          updateFlag: checkFlag,
          controller: controller,
          todoList: todoList,
          index: index,
          updateDateTime: updateDateTime,
          addTodo: addTodo,
        );
      });
}
