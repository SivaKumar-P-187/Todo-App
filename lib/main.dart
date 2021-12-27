// ignore_for_file: prefer_const_constructors
///to develop the todo application with providers
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/homepage.dart';
import 'package:todoapp/provider/todo_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => TodoProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}
