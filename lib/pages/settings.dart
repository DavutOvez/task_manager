import 'package:flutter/material.dart';

import 'package:task_manager/main.dart';
import 'package:task_manager/models/database_helper.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                color: Colors.grey[300],
              ),
              child: Icon(Icons.check, size: 80, color: Colors.green),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              'Task Manager',
              style: TextStyle(fontSize: 25, color: Colors.grey[400]),
            ),
          ),
          Center(
            child: Text(
              'version: 1.0',
              style: TextStyle(fontSize: 15, color: Colors.grey[400]),
            ),
          ),
          SizedBox(height: 50),
          Divider(indent: 25, endIndent: 25),
          SizedBox(height: 15),
          Center(
            child: SizedBox(
              width: 300,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10),
                  ),
                ),
                onPressed: () async {
                  final confirmed = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Delete all tasks?"),
                    content: Text("This action cannot be undone."),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: Text("Yes"),
                      ),
                    ],
                  ),
                );

                if (confirmed == true) {
                  await _dbHelper.deleteAllTasks();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("All tasks have been deleted")),
                  );
                }
                },
                child: Text(
                  'CLEAR ALL DATA',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Divider(indent: 25, endIndent: 25),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsetsGeometry.only(left: 45),
            child: Text(
              'Terms and Condition',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),

          SizedBox(height: 25),
          Padding(
            padding: EdgeInsetsGeometry.only(left: 45),
            child: Text(
              'Privacy Policy',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          SizedBox(height: 15),
          Divider(indent: 25, endIndent: 25),
        ],
      ),
    );
  }
}
