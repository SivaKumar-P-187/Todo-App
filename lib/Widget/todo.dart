// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
///To display all the todo expect completed todo
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/Widget/display_todo.dart';
import 'package:todoapp/Widget/edit_todo.dart';
import 'package:todoapp/management/sharedpreferencehelper.dart';
import 'package:todoapp/model/todofin.dart';
import 'package:todoapp/provider/todo_provider.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
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
    List<Todo> todoFinal = [];
    todoFinal = provider.todos;

    ///to sort todo based on time stamp
    todoFinal.sort((a, b) {
      return a.created!.compareTo(b.created!);
    });

    return todoFinal.isEmpty
        ? Center(
            child: Text(
              "No Todo Available",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
                fontSize: 25.0,
              ),
            ),
          )
        : ListView.separated(
            shrinkWrap: true,
            reverse: true,
            itemCount: todoFinal.length,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(8.0),
            itemBuilder: (context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditTodo(
                        todo: todoFinal[index],
                      ),
                    ),
                  );
                },
                child: Display(
                  todo: todoFinal[index],
                  isCompleted: false,
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => Container(
              height: 8.0,
              color: Colors.white,
            ),
          );
  }
}
