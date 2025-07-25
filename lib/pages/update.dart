import 'package:flutter/material.dart';
import 'package:task_manager/main.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/models/database_helper.dart';

class UpdateorDeleteTask extends StatefulWidget {
  final int index;
  const UpdateorDeleteTask({super.key, required this.index});

  @override
  State<StatefulWidget> createState() => UpdateorDeleteTaskState();
}

class UpdateorDeleteTaskState extends State<UpdateorDeleteTask> {
  String? _selected_priority;
  var _priorities = ['High', 'Medium', 'Low'];
  TextEditingController _dateeditController = TextEditingController();
  TextEditingController _titleeditController = TextEditingController();
  TextEditingController _priorityeditController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        String day = picked.day.toString().padLeft(2, '0');
        String month = picked.month.toString().padLeft(2, '0');
        String year = picked.year.toString();
        _dateeditController.text = "$day.$month.$year"; 
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _titleeditController.text = tasks[widget.index][1]
        .toString();
    _dateeditController.text = tasks[widget.index][2].toString();
    _selected_priority = tasks[widget.index][3].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Task',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            SizedBox(
              width: 330,
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  label: Text('Title'),
                ),
                controller: _titleeditController,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 330,
              height: 50,
              child: TextField(
                controller: _dateeditController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Date',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () => _selectDate(context),
              ),
            ),
            SizedBox(height: 20),

            SizedBox(
              height: 50,
              width: 330,
              child: DropdownButtonHideUnderline(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<String>(
                    hint: Text('Priority'),
                    value: _selected_priority,
                    isExpanded: true,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selected_priority = newValue!;
                      });
                    },
                    icon: Icon(Icons.assistant_navigation, color: Colors.red),
                    items: _priorities.map((String priority) {
                      return DropdownMenuItem<String>(
                        value: priority,
                        child: Text(priority),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 330,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                onPressed: () {
                  List<Object> updatedTask = [
                    tasks[widget.index][0],
                    _titleeditController.text,
                    _dateeditController.text,
                    _selected_priority.toString(),
                    tasks[widget.index][4],
                  ];
                  Navigator.pop(context, updatedTask);
                },
                child: Text(
                  'Update',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 330,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                onPressed: () {
                  var task_id = tasks[widget.index][0] as int;
                  final DatabaseHelper _databaseHelper  = DatabaseHelper();
                  _databaseHelper.deleteTask(task_id);
                  Navigator.pop(context);
                },
                child: Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
