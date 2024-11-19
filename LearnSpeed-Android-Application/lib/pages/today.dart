import 'package:flutter/material.dart';
import 'package:todo_list/pages/todo_list.dart';


class TodayTask extends StatefulWidget {
  const TodayTask({Key? key}) : super(key: key);
  _TodayTaskState createState() => _TodayTaskState();
}

class _TodayTaskState extends State<TodayTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: TodoApp(),)
    );
  }
}
