import 'package:flutter/material.dart';
import 'dart:async';

import 'package:task_manager/main.dart';

class LoadingPage extends StatefulWidget {
  LoadingPage({super.key});

  @override
  State<StatefulWidget> createState() => LoadingPageState();
}

class LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>MyHomePage()));
    });
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Column(children: [
        SizedBox(height: 120,),
        Center(child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(90),color: Colors.grey[300]),child: Icon(Icons.check,size: 150,color: Colors.green,)),),
        SizedBox(height: 10,),
        Center(child: Text('Task Manager',style: TextStyle(fontSize: 30,color: Colors.grey[400]),) ,),
        SizedBox(height: 500,),
        Center(child: Text('Created by: DavutOvez',style: TextStyle(fontSize: 20,color: Colors.grey),),)
      ],),
      
    );
  }
}