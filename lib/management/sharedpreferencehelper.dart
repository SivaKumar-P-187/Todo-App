// ignore_for_file: prefer_const_declarations

///to the details of todo list to the local storage and get details from local storage
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/model/todofin.dart';

class SharedPreferencesHelper {
  static final todoListKey = "TodoListKey";

  ///to store todo details
  Future<bool> setTodo(List<Todo> todos) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(todoListKey);
    String todoString = encode(todos);
    return preferences.setString(todoListKey, todoString);
  }

  ///to convert todo list into the string
  static String encode(List<Todo> todos) {
    return json.encode(
        todos.map<Map<String, dynamic>>((todo) => todo.toJson()).toList());
  }

  ///to convert string into list
  static List<Todo> decode(String todoString) {
    return (json.decode(todoString) as List<dynamic>)
        .map<Todo>((todo) => Todo.fromJson(todo))
        .toList();
  }

  ///to return the todo list from local storage
  Future<List<Todo>> getTodo() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String? todoString = preferences.getString(todoListKey);
    if (todoString != null) {
      List<Todo> todo = decode(todoString);
      return todo;
    } else {
      return [];
    }
  }
}
