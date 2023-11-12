import 'package:flutter/material.dart';
import 'package:to_do_app/todo_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TodoService _todoService = TodoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
