import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class RouteNames {
  static const home = '/';
  static const add = '/addtask';
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RouteNames.home,
      routes: {
        RouteNames.home: (context) => const MyHomePage(),
        RouteNames.add: (context) => AddTaskPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
var tasks = [
  ['Task1', '01.01.2020','Low', false],
  ['Task2', '01.01.2020','High', false],
  ['task3', '01.01.2020','Medium' ,false],
];

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.grid_on_sharp)),
        title: Row(
          children: [
            Text('Task', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              'Manager',
              style: TextStyle(
                color: Colors.red[400],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.refresh_rounded)),
          IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
        ],
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
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: SizedBox(width: 10),
                  title: Text(tasks[index][0].toString()),
                  subtitle: Text('${tasks[index][1].toString()} • ${tasks[index][2]}'),
                  trailing: Checkbox(
                    value: tasks[index][3] as bool,
                    onChanged: (value) {
                      setState(() {
                        tasks[index][3] = value!;
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.white,
        onPressed: () async {
          final newTask = await Navigator.pushNamed(context, RouteNames.add) as List<Object>?;
          if (newTask != null) {
            setState(() {
              tasks.add(newTask);
      });
    }
        },
        
        child: Icon(Icons.add),
      ),
    );
  }
}

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
        _dateController.text = "$day.$month.$year"; // 👈 istediğin format
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
                      _selected_priority!, // 👈 dropdown'dan gelen bilgi
                      false,
                    ];
                    Navigator.pop(context,newTask); // 👈 veriyi geri gönderiyoruz
                    
                    
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
