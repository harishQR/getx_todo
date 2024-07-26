
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo/views/dup.dart';
import 'package:getx_todo/views/home_pg.dart';
import 'controllers/controllerof_todo.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: home_pg(),
    );
  }
}

