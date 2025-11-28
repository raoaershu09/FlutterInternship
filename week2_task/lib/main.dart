import 'package:flutter/material.dart';
import 'package:week2_task/screens/todo_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List App',
      home: TodoListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}