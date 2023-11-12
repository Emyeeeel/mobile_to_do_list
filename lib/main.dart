import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_app/screens/main_screen.dart';
import 'package:to_do_app/todo_item.dart';
import 'package:to_do_app/todo_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoItemAdapter());
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final TodoService _todoService = TodoService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ignore: deprecated_member_use
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFF2ECFF),
      ),
      home: FutureBuilder(
        future: _todoService.getAllTodos(),
        builder: (context, AsyncSnapshot<List<TodoItem>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MyHomePage(snapshot.data ?? []);
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
