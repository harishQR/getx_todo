
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TodoController extends GetxController {
  var todos = <Todo>[].obs;
  TextEditingController todotasknamecontroller = TextEditingController();
  TextEditingController todocontentcontroller = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadTodos();
  }

  void display() {
    var newTodo = Todo(
      title: todotasknamecontroller.text,
      content: todocontentcontroller.text,
    );
    todos.add(newTodo);
    saveTodos();
  }

  void editTodoContent(int index) {
    todos[index].title = todotasknamecontroller.text;
    todos[index].content = todocontentcontroller.text;
    todos.refresh();
    saveTodos();
  }

  void deleteTodoContent(int index) {
    todos.removeAt(index);
    saveTodos();
  }

  void saveTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> todoList = todos.map((todo) => jsonEncode(todo.toJson())).toList();
    await prefs.setStringList('todos', todoList);
  }

  void loadTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? todoList = prefs.getStringList('todos');
    if (todoList != null) {
      todos.value = todoList.map((todo) => Todo.fromJson(jsonDecode(todo))).toList();
    }
  }
}

class Todo {
  String title;
  String content;

  Todo({
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'content': content,
  };

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    title: json['title'],
    content: json['content'],
  );
}
