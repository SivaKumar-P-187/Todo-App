// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_is_empty

///To show alert dialog to show form to add new todo

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///other class package
import 'package:todoapp/new_todo/todoform.dart';
import 'package:todoapp/provider/todo_provider.dart';
import 'package:todoapp/model/todofin.dart';
import 'package:todoapp/management/sharedpreferencehelper.dart';

class AlertTextFormField extends StatefulWidget {
  const AlertTextFormField({Key? key}) : super(key: key);

  @override
  _AlertTextFormFieldState createState() => _AlertTextFormFieldState();
}

class _AlertTextFormFieldState extends State<AlertTextFormField> {
  final _key = GlobalKey<FormState>();

  ///to validate the form
  String title = "";

  ///to store the title of new todo
  String description = "";

  ///to store the description of new to todo
  @override
  Widget build(BuildContext context) {
    return Center(
      ///to add alert window
      child: AlertDialog(
        content: Form(
          key: _key,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///to display title for alert dialog
              Text(
                'Todo',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),

              ///form widget
              TodoForm(
                title: title,

                ///to check whether the title field of new todo is empty or not
                onValidator: (_) {
                  if (title.isEmpty) {
                    return "Title Should not be Empty";
                  }
                  return null;
                },
                description: description,

                ///to update description value from description field
                onDescription: (description) {
                  setState(() {
                    this.description = description;
                  });
                },

                ///to update title value from title field
                onTitle: (title) {
                  setState(() {
                    this.title = title;
                  });
                },

                ///to save the todo to the list
                onSave: () async {
                  if (_key.currentState!.validate()) {
                    final todo = Todo(
                        id: 1,
                        title: title,
                        description: description,
                        created: DateTime.now(),
                        isDone: false);
                    final provider =
                        Provider.of<TodoProvider>(context, listen: false);
                    provider.addTodo(todo);
                    List<Todo> todoFin = provider.todos;
                    await SharedPreferencesHelper().setTodo(todoFin);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
