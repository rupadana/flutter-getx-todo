import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:openaccess/models/TodoModel.dart';
import 'package:openaccess/pages/todo/list/todo_controller.dart';
import 'package:openaccess/services/api_controller.dart';

class TodoCreateController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TodoController todoController = Get.find<TodoController>();
  TodoModel? todoEdit;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var args = Get.arguments;
    if (args != null && args['todo'] != null) {
      todoEdit = args['todo'];
      titleController.text = "${todoEdit?.title}";
    }
  }

  createTodo() async {
    todoController.todos.value = [
      ...todoController.todos.value,
      TodoModel(title: titleController.text)
    ];
    todoController.update(['list-todo']);
    Get.back();
  }

  updateTodo() async {
    todoEdit?.title = titleController.text;
    todoController.update(['list-todo']);
    Get.back();
  }
}
