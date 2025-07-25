import 'package:flutter/material.dart';


import 'package:task_manager/main.dart';
import 'package:task_manager/models/database_helper.dart';
import 'package:task_manager/models/task.dart';


class HistoryPage extends StatefulWidget {
  HistoryPage({super.key});

  @override
  State<StatefulWidget> createState() => HistoryPageState();
}


class HistoryPageState extends State<HistoryPage> {
  List<Task> completedTasks = [];

  @override
  void initState() {
    super.initState();
    _loadCompletedTasks();
  }

  void _loadCompletedTasks() async {
    final tasks = await DatabaseHelper().getTasks();
    final filtered = tasks.where((task) => task.completed).toList();
    setState(() {
      completedTasks = filtered;
    });
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 350,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: completedTasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: SizedBox(width: 10),
                  title:  Text(completedTasks[index].title,
                    style: TextStyle(
                      decoration: completedTasks[index].completed
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
                                        ),
                    ),
                  
                  subtitle: Text(
                    '${completedTasks[index].date.toString()} • ${completedTasks[index].level}',
                  ),
                  trailing: IconButton(
                    onPressed: () async {
                      await DatabaseHelper().deleteTask(completedTasks[index].id!);
                      _loadCompletedTasks(); // Silme sonrası listeyi güncelle
                    }, 
                    icon: Icon(Icons.delete_forever, size: 30, color: Colors.red),
                  ),
                );
              },
            ),
          ),
        ]
      )
    );
  }
}