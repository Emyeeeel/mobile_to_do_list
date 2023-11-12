import 'package:hive/hive.dart';
import 'package:to_do_app/todo_item.dart';

class TodoService {
  final String _boxName = "todoBox";

  Future<Box<TodoItem>> get _box async =>
      await Hive.openBox<TodoItem>(_boxName);

  Future<void> addItem(TodoItem todoItem) async {
    var box = await _box;

    await box.add(todoItem);
  }

  Future<List<TodoItem>> getAllTodos() async {
    var box = await _box;

    return box.values.toList();
  }

  Future<void> deleteItem(int index) async {
    var box = await _box;
    var key = box.keyAt(index);
    await box.delete(key);
  }

  Future<void> updateIsCompleted(int index, TodoItem todoItem) async {
    var box = await _box;

    todoItem.isCompleted = !todoItem.isCompleted;
    await box.putAt(index, todoItem);
  }
}
