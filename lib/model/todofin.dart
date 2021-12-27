// To parse this JSON data, do
//
//     final todo = todoFromJson(jsonString);

///to all the details about the particular todo
import 'package:meta/meta.dart';
import 'dart:convert';

List<Todo> todoFromJson(String str) =>
    List<Todo>.from(json.decode(str).map((x) => Todo.fromJson(x)));

String todoToJson(List<Todo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Todo {
  Todo({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.created,
    @required this.isDone,
  });

  int? id;
  String? title;
  String? description;
  DateTime? created;
  bool? isDone;

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        created: DateTime.parse(json["created"]),
        isDone: json["isDone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "created": created!.toIso8601String(),
        "isDone": isDone,
      };
}
