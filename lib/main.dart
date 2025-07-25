import 'package:flutter/material.dart';
import 'package:task_manager/models/database_helper.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/pages/add.dart';
import 'package:task_manager/pages/settings.dart';
import 'package:task_manager/pages/update.dart';
import 'package:task_manager/pages/loading.dart';
import 'package:task_manager/pages/history.dart';
void main() {
  runApp(const MyApp());
}

class RouteNames {
  static const home = '/';
  static const add = '/addtask';
  static const update_delete = '/update_delete';
  static const history = '/history';
  static const settings = '/settings';
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RouteNames.home,
      routes: {
        RouteNames.home: (context) => LoadingPage(),
        RouteNames.add: (context) => AddTaskPage(),
        RouteNames.update_delete: (context) {
          final args = ModalRoute.of(context)!.settings.arguments as int;
          return UpdateorDeleteTask(index: args);

        },
        RouteNames.history:(context)=> HistoryPage(),
        RouteNames.settings:(context)=> SettingsPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

var tasks = [];

class _MyHomePageState extends State<MyHomePage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  List<Task> _tasks = [];
  

  @override
  void initState() {
    super.initState();
    // _addTask();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
  tasks.clear();
  List<Task> tasks_temp = await _databaseHelper.getTasks();

  // completed = false olanları filtrele
  List<Task> activeTasks = tasks_temp.where((task) => task.completed == false).toList();

  setState(() {
    _tasks = activeTasks;

    for (var element in _tasks) {
      List<Object> d = [
        element.id!,
        element.title,
        element.date,
        element.level,
        element.completed,
      ];
      tasks.add(d);
    }
  });
}

  Future<void> _addTask() async {
    final task = Task(
      title: 'Read Book',
      date: '01.01.2020',
      level: 'High',
      completed: false,
    );
    await _databaseHelper.insertTask(task);
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.apps)),
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
          IconButton(onPressed: () {
          Navigator.pushNamed(context, RouteNames.history);
          }, icon: Icon(Icons.history_outlined)),
          IconButton(onPressed: () {
            Navigator.pushNamed(context, RouteNames.settings);
          }, icon: Icon(Icons.settings)),
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
                          var updatedTask_ = updatedTask as List<Object>;
                          var task = Task(
                            id: int.tryParse(updatedTask_[0].toString()),
                            title: updatedTask_[1].toString(),
                            date: updatedTask_[2].toString(),
                            level: updatedTask_[3].toString(),
                            completed: updatedTask_[4] as bool,
                          );
                          _databaseHelper.updateTask(task);
                          _loadTasks();
                        });
                      } else {
                        setState(() {
                          _loadTasks();
                        });
                      }
                    },

                    child: Text(tasks[index][1].toString(),
                    style: TextStyle(
                      decoration: tasks[index][4]
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
                                        ),
                    ),
                  ),
                  subtitle: Text(
                    '${tasks[index][2].toString()} • ${tasks[index][3]}',
                  ),
                  trailing: Checkbox(
                    value: tasks[index][4] as bool,
                    onChanged: (value) async {
                      setState(() {
                        tasks[index][4] = value!;
                      });

                      // Veritabanını güncelle
                      Task task = Task(
                        id: tasks[index][0] as int,
                        title: tasks[index][1] as String,
                        date: tasks[index][2] as String,
                        level: tasks[index][3] as String,
                        completed: value!,
                      );
                      await _databaseHelper.updateTask(task);
                      _loadTasks(); // Güncel listeyi yükle
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
              Task task = Task(title: newTask[0].toString(), date: newTask[1].toString(), level: newTask[2].toString(), completed: newTask[3] as bool);
              _databaseHelper.insertTask(task);
              _loadTasks();
            });
          }
        },

        child: Icon(Icons.add),
      ),
    );
  }
}
