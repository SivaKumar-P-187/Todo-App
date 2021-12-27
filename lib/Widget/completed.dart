// ignore_for_file: prefer_const_constructors
///To display the completed todo in order of time stamp of complete
import 'package:flutter/material.dart';
import 'package:todoapp/Widget/display_todo.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/management/sharedpreferencehelper.dart';
import 'package:todoapp/provider/todo_provider.dart';
import 'package:todoapp/model/todofin.dart';

class Completed extends StatefulWidget {
  const Completed({Key? key}) : super(key: key);

  @override
  _CompletedState createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  List<Todo> todoFinal1 = [];
  buildTodo() async {
    await getValue();
  }

  getValue() async {
    ///to get data of todo from local storage
    todoFinal1 = await SharedPreferencesHelper().getTodo();
    final provider = Provider.of<TodoProvider>(context, listen: false);
    final t = provider.todos;

    ///to remove temporary on page change and remove duplicated data any page change
    for (var m in t) {
      provider.removeTodo(m);
    }

    ///to add data from local storage on page change
    for (var t in todoFinal1) {
      provider.addTodo(t);
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    buildTodo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///To get data from provider on new todo added
    final provider = Provider.of<TodoProvider>(context);
    final todoFinal = provider.completeTodos;

    ///to sort todo based on time stamp
    todoFinal.sort((a, b) {
      return a.created!.compareTo(b.created!);
    });
    return todoFinal.isEmpty
        ? Center(
            child: Text(
              "No Completed Todo Available",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
                fontSize: 25.0,
              ),
            ),
          )
        : ListView.separated(
            itemCount: todoFinal.length,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(8.0),
            itemBuilder: (context, int index) {
              return Display(
                todo: todoFinal[index],
                isCompleted: true,
              );
            },
            separatorBuilder: (BuildContext context, int index) => Container(
              height: 8.0,
              color: Colors.white,
            ),
          );
  }
}
