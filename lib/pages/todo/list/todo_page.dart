import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:openaccess/components/SkeletonLoading.dart';
import 'package:openaccess/models/TodoModel.dart';
import 'package:openaccess/pages/todo/create/todo_create_page.dart';
import './todo_controller.dart';

class TodoPage extends GetView<TodoController> {
  static const route = "/todo-page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TodoPage'),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(top: 20, right: 20, left: 20),
            child: GetBuilder<TodoController>(
              id: "list-todo",
              builder: (controller) => Column(
                children: controller.todoIsFetching.value
                    ? skeleton
                    : controller.todos.value
                        .map((e) => todoItem(title: "${e.title}", model: e))
                        .toList(),
              ),
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(TodoCreatePage.route);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget todoItem({required String title, required TodoModel model}) {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: 2,
          child: Container(
            child: Text("$title"),
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Get.toNamed(TodoCreatePage.route, arguments: {"todo": model});
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.yellow,
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.defaultDialog(
                      title: "Konfirmasi",
                      middleText: "Yakin akan menghapus todo ${model.title}?",
                      actions: [
                        TextButton(
                          onPressed: () {
                            controller.todos.value.removeWhere(
                                (todo) => todo.title == model.title);
                            Get.back();
                            controller.update(['list-todo']);
                          },
                          child: Text("Ya"),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            "Tidak",
                            style: TextStyle(
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      ]);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  List<Widget> skeleton = [
    SkeletonLoading(
      height: 20,
    ),
    SizedBox(
      height: 15,
    ),
    SkeletonLoading(
      height: 20,
    ),
    SizedBox(
      height: 15,
    ),
    SkeletonLoading(
      height: 20,
    ),
    SizedBox(
      height: 15,
    ),
    SkeletonLoading(
      height: 20,
    ),
    SizedBox(
      height: 15,
    ),
    SkeletonLoading(
      height: 20,
    ),
  ];
}
