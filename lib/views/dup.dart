
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo/controllers/controllerof_todo.dart';

class home extends StatefulWidget {
  home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final TodoController todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Todo App",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          todoController.todotasknamecontroller.clear();
          todoController.todocontentcontroller.clear();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: TextField(
                  controller: todoController.todotasknamecontroller,
                  decoration: InputDecoration(
                    hintText: "Enter title",
                  ),
                ),
                content: TextField(
                  controller: todoController.todocontentcontroller,
                  decoration: InputDecoration(
                    hintText: "Enter task",
                  ),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          todoController.display();
                          Navigator.pop(context);
                        },
                        child: Text("Add"),
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
                  () => ListView.builder(
                itemCount: todoController.todos.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () {
                      todoController.todotasknamecontroller.text = todoController.todos[index].title;
                      todoController.todocontentcontroller.text = todoController.todos[index].content;
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: TextField(
                              controller: todoController.todotasknamecontroller,
                              decoration: InputDecoration(
                                hintText: "Edit title",
                              ),
                            ),
                            content: TextField(
                              controller: todoController.todocontentcontroller,
                              decoration: InputDecoration(
                                hintText: "Edit task",
                              ),
                            ),
                            actions: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      todoController.editTodoContent(index);
                                      Navigator.pop(context);
                                    },
                                    child: Text("Edit"),
                                  ),
                                  SizedBox(width: 20),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(
                          todoController.todos[index].title,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        subtitle: Text(
                          todoController.todos[index].content,
                          style: TextStyle(fontSize: 20),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Are you sure, about deleting this content?"),
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          todoController.deleteTodoContent(index);
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Yes',
                                          style: TextStyle(color: Colors.red, fontSize: 24),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'No',
                                          style: TextStyle(color: Colors.grey, fontSize: 24),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
