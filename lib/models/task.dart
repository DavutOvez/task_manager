import 'package:flutter/material.dart';

class Task {
  final int? id;

  final String title;
  final String date;
  final String level;
  final bool completed;

  Task({this.id, required this.title,required this.date,required this.level , required this.completed});

  Map<String, dynamic> toMap() {

    return {'id': id, 'title': title,'date':date,'level': level ,'completed':completed ? 1:0};
    
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(id: map['id'], title: map['title'],date: map['date'],level: map['level'],completed: map['completed'] ==1);
  }

  @override
  String toString() {
    return 'Task-${id} : ${title}';
  }
}
