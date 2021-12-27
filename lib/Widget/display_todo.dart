// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
///To do display the single todo with details and checkbox to mark it as completed or not
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/Widget/edit_todo.dart';
import 'package:todoapp/management/sharedpreferencehelper.dart';
import 'package:todoapp/model/todofin.dart';
import 'package:todoapp/provider/todo_provider.dart';

class Display extends StatefulWidget {
  final Todo todo;
  final bool isCompleted;
  const Display({Key? key, required this.todo, required this.isCompleted})
      : super(key: key);

  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  @override
  Widget build(BuildContext context) {
    ///to have rounded corner
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),

      ///to add slidable functionality to each todo
      child: Slidable(
        key: const ValueKey(0),
        startActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            ///to add edit functionality to todo
            SlidableAction(
              onPressed: (_) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditTodo(todo: widget.todo),
                  ),
                );
              },
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),

        ///to add delete functionality to todo
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) async {
                final provider =
                    Provider.of<TodoProvider>(context, listen: false);
                provider.removeTodo(widget.todo);
                List<Todo> todoFin = provider.todos;
                await SharedPreferencesHelper().setTodo(todoFin);
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: buildWidget(),
      ),
    );
  }

  ///to display todo
  buildWidget() {
    String formattedDate =
        DateFormat('yyyy-MM-dd').format(widget.todo.created!);
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          ///to display checkbox with particular size
          Transform.scale(
            scale: 1.5,
            child: Checkbox(
              value: widget.todo.isDone,
              activeColor: Colors.pinkAccent,
              checkColor: Colors.white,
              onChanged: (_) async {
                final provider =
                    Provider.of<TodoProvider>(context, listen: false);
                provider.toggleIsDone(widget.todo);
                final t = provider.todos;
                await SharedPreferencesHelper().setTodo(t);
              },
            ),
          ),
          SizedBox(
            width: 10.0,
          ),

          ///to display title and description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      widget.todo.title!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                        color: Colors.pinkAccent,
                      ),
                    ),
                    Text(
                      formattedDate,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.black.withOpacity(0.5),
                        decoration: widget.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                widget.todo.description != null
                    ? Text(
                        widget.todo.description!,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20.0,
                          height: 1.5,
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
