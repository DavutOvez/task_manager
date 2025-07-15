import 'package:flutter/material.dart';
import 'package:task_manager/pages/add.dart';
import 'package:task_manager/pages/update.dart';

void main() {
  runApp(const MyApp());
}

class RouteNames {
  static const home = '/';
  static const add = '/addtask';
  static const update_delete = '/update_delete';
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
        RouteNames.update_delete: (context) {
          final args = ModalRoute.of(context)!.settings.arguments as int;
          return UpdateorDeleteTask(index: args);
        },
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
  ['Task1', '01.01.2020', 'Low', false],
  ['Task2', '01.01.2020', 'High', false],
  ['task3', '01.01.2020', 'Medium', false],
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
                  title: TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        EdgeInsets.zero,
                      ), // İç boşluğu sıfır yap
                      alignment: Alignment.centerLeft,
                    ),
                    onPressed: () async {
                      final updatedTask = await Navigator.pushNamed(
                        context,
                        RouteNames.update_delete,
                        arguments: index,
                      );
                      if (updatedTask != null) {
                        setState(() {
                          tasks[index]=updatedTask as List<Object>;
                        });
                      } else{
                        setState(() {
                          
                        });
                      }
                    },
                    
                    child: Text(tasks[index][0].toString()),
                  ),
                  subtitle: Text(
                    '${tasks[index][1].toString()} • ${tasks[index][2]}',
                  ),
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
          final newTask =
              await Navigator.pushNamed(context, RouteNames.add)
                  as List<Object>?;
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
