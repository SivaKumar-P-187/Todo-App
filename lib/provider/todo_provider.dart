// ignore_for_file: prefer_final_fields

///to provider provider functionality to  todo app
import 'package:flutter/cupertino.dart';
import 'package:todoapp/model/todofin.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> _todo = [];

  TodoProvider() {
    _todo.clear();
  }

  ///to get all todo where its is not complete
  List<Todo> get todos => _todo.where((todo) => todo.isDone == false).toList();

  ///to get all todo where its is complete
  List<Todo> get completeTodos =>
      _todo.where((todo) => todo.isDone == true).toList();

  ///to add todo to the todo list
  void addTodo(Todo todo) {
    _todo.add(todo);
    notifyListeners();
  }

  ///to edit particular todo
  void editTodo(Todo todo, String title, String description) {
    todo.title = title;
    todo.description = description;
    notifyListeners();
  }

  ///to mark particular to as completed or not and change the timestamp
  void toggleIsDone(Todo todo) {
    todo.isDone = !todo.isDone!;
    todo.created = DateTime.now();
    notifyListeners();
  }

  ///to remove particular todo from todo list
  void removeTodo(Todo todo) {
    _todo.remove(todo);
    notifyListeners();
  }
}
