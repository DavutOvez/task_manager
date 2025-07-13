import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var davut = [
    ['Task1','01.01.2020',false],
    ['Task2','01.01.2020',false],
    ['task3','01.01.2020',false],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.grid_on_sharp)),
        title: Row(
          children: [
            Text('Task',style: TextStyle(fontWeight: FontWeight.bold),),
            Text('Manager', style: TextStyle(color: Colors.red[400],fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.refresh_rounded)),
          IconButton(onPressed: (){}, icon: Icon(Icons.settings))
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 350,height: 50,child: TextField(decoration: InputDecoration(filled: true, fillColor: Colors.grey[200], border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),),)
            ],
          ),
          Expanded(child: ListView.builder(itemCount: davut.length,itemBuilder:(context,index){
            return ListTile(
              leading: SizedBox(width: 10,),
              title: Text( davut[index][0].toString()),
              subtitle: Text( davut[index][1].toString()),
              trailing: Checkbox(value: davut[index][2] as bool, onChanged: (value){
                setState(() {
                  davut[index][2] = value!;
                });
              }),
            );
          }  ),)
        ],
      ),
      floatingActionButton: FloatingActionButton(shape:CircleBorder(),backgroundColor: Colors.white,onPressed: (){
        setState(() {
          davut.add(['oraz','01.01.2010',false]);
        });
      }, child: Icon(Icons.add),),
    );
  }
}
