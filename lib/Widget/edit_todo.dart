// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

///To edit the existing todo by get the data from todo list
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/management/sharedpreferencehelper.dart';
import 'package:todoapp/model/todofin.dart';
import 'package:todoapp/new_todo/todoform.dart';
import 'package:todoapp/provider/todo_provider.dart';

class EditTodo extends StatefulWidget {
  final Todo todo;
  const EditTodo({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  _EditTodoState createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  final _key = GlobalKey<FormState>();
  String title = "";
  String description = "";

  ///to store the existing todo value from existing value
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      title = widget.todo.title!;
      description = widget.todo.description!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        leading: BackButton(),
        title: Text(
          "Edit Todo",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Icon(Icons.delete),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Form(
              key: _key,
              child: TodoForm(
                title: title,

                ///to check whether title field is empty or not
                onValidator: (_) {
                  if (title.isEmpty) {
                    return "Title Should not be Empty";
                  }
                  return null;
                },
                description: description,

                ///to store description value from description field
                onDescription: (description) {
                  setState(() {
                    this.description = description;
                  });
                },

                ///to store title value from the title field
                onTitle: (title) {
                  setState(() {
                    this.title = title;
                  });
                },

                ///to save todo to provider and local storage
                onSave: () async {
                  if (_key.currentState!.validate()) {
                    final provider =
                        Provider.of<TodoProvider>(context, listen: false);
                    provider.editTodo(widget.todo, title, description);
                    List<Todo> todoFin = provider.todos;
                    await SharedPreferencesHelper().setTodo(todoFin);
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
