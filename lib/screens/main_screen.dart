import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_app/todo_item.dart';
import 'package:to_do_app/todo_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage(List<TodoItem> list, {super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TodoService _todoService = TodoService();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text(
          'To Do List App',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF00C896),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<TodoItem>('todoBox').listenable(),
        builder: (context, Box<TodoItem> box, _) {
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              var todo = box.getAt(index);
              return ListTile(
                title: Text(
                  todo!.title,
                  style: TextStyle(
                    color: todo.isCompleted
                        ? const Color(0xFF4D4D4D)
                        : const Color(0xFF212121),
                    decoration: todo.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                leading: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (val) {
                    _todoService.updateIsCompleted(index, todo);
                  },
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Color(0xFF212121),
                  ),
                  onPressed: () {
                    _todoService.deleteItem(index);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF00C896),
        onPressed: () async {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Add Todo'),
                  content: TextField(
                    controller: _controller,
                  ),
                  actions: [
                    ElevatedButton(
                      child: const Text('Add'),
                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          var todo = TodoItem(_controller.text);
                          _todoService.addItem(todo);
                          _controller.clear();
                          Navigator.pop(context);
                        }
                      },
                    )
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
