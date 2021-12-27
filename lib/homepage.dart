// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

///other class packages
import 'package:todoapp/new_todo/alerttextform.dart';
import 'package:todoapp/Widget/completed.dart';
import 'package:todoapp/Widget/todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ///members of bottom navigation bar to change screen on tab
  final tab = [
    TodoList(),
    Completed(),
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Todo App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      body: tab[selectedIndex],

      ///bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        currentIndex: selectedIndex,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        selectedIconTheme: IconThemeData(
          color: Colors.white,
          size: 30.0,
        ),
        unselectedIconTheme: IconThemeData(
          color: Colors.white70,
          size: 30.0,
        ),
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 15.0,
          color: Colors.white,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 15.0,
          color: Colors.white70,
        ),
        backgroundColor: Colors.pinkAccent,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Todos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: "Completed Todo",
          )
        ],
      ),

      ///floating action button to add new todo
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertTextFormField();
          },
        ),
        child: Icon(Icons.add),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        backgroundColor: Colors.pinkAccent,
      ),
    );
  }
}
