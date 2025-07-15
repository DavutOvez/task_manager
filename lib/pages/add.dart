import 'package:flutter/material.dart';


class AddTaskPage extends StatefulWidget {
  AddTaskPage({super.key});

  @override
  State<StatefulWidget> createState() => AddTaskPageState();
}

class AddTaskPageState extends State<AddTaskPage> {
  String? _selected_priority;
  var _priorities = ['High', 'Medium', 'Low'];
  TextEditingController _dateController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _priorityController = TextEditingController();

  

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
        _dateController.text = "$day.$month.$year";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Task',
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
                controller: _titleController,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 330,
              height: 50,
              child: TextField(
                controller: _dateController,
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
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red),),
                onPressed: () {
                  if (_titleController.text.isNotEmpty &&
                      _dateController.text.isNotEmpty &&
                      _selected_priority != null) {
                    var newTask = [
                      _titleController.text,
                      _dateController.text,
                      _selected_priority!,
                      false,
                    ];
                    Navigator.pop(context,newTask);
                    
                    
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please fill in all the fields.")),
                    );
                  }
                },
                child: Text('Add',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
