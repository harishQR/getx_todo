
import 'package:flutter/cupertino.dart';

class Todo{
  String title;
  bool isdone;
  String content;


Todo({
  required this.title,
  this.isdone = false,
  required this.content,
});
}


