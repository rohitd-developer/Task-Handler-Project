import 'package:flutter/material.dart';
import 'package:flutter_app/screens/task_list.dart';
import 'package:flutter_app/screens/task_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskHandler',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueAccent[300],
      ),
      home: TaskList(),
    );
  }
}
