// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

///to to get the todo value from the user to add new todo or edit todo
import 'package:flutter/material.dart';

class TodoForm extends StatefulWidget {
  final String title;
  final String description;
  final ValueChanged onTitle;
  final ValueChanged onDescription;
  final VoidCallback onSave;
  final FormFieldValidator<String?> onValidator;
  const TodoForm({
    Key? key,
    this.title = "",
    required this.onValidator,
    this.description = "",
    required this.onDescription,
    required this.onTitle,
    required this.onSave,
  }) : super(key: key);

  @override
  _TodoFormState createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildTitle(),
          SizedBox(
            height: 4,
          ),
          buildDescription(),
          SizedBox(
            height: 8,
          ),
          buildSave(),
        ],
      ),
    );
  }

  ///To get the title of new todo
  Widget buildTitle() => TextFormField(
        initialValue: widget.title,
        validator: widget.onValidator,
        onChanged: widget.onTitle,
        maxLines: 1,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          label: Text(
            'Title',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

  ///To get the description new todo
  Widget buildDescription() => TextFormField(
        initialValue: widget.description,
        onChanged: widget.onDescription,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          label: Text(
            'Description',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        maxLines: 3,
      );

  ///To save the new todo
  Widget buildSave() => SizedBox(
        width: double.infinity,
        child: MaterialButton(
          color: Colors.black,
          onPressed: widget.onSave,
          child: Text(
            "Save",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ),
      );
}
