import 'package:flutter/material.dart';

import 'AddTodo.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Application name
      title: 'learn speed',
      // Application theme data, you can set the colors for the application as
      // you want
      debugShowCheckedModeBanner: false,
      // A widget which will be started on application startup
      home: AddTodoPage(),
    );
  }
}
