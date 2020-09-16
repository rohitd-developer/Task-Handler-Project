import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/task.dart';
import 'package:flutter_app/screens/drawer.dart';
import 'package:flutter_app/utils/database_helper.dart';
import 'package:flutter_app/screens/task_detail.dart';
import 'package:sqflite/sqflite.dart';

class TaskList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TaskListState();
  }
}

class TaskListState extends State<TaskList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Task> taskList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (taskList == null) {
      taskList = List<Task>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      drawer: MainDrawer(),
      body: getTaskListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB clicked');
          navigateToDetail(Task('', '', 2), 'Add Task');
        },
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getTaskListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor:
                  getPriorityColor(this.taskList[position].priority),
              child: getPriorityIcon(this.taskList[position].priority),
            ),
            title: Text(
              this.taskList[position].title,
              style: titleStyle,
            ),
            subtitle: Text(this.taskList[position].date),
            trailing: GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onTap: () {
                _delete(context, taskList[position]);
              },
            ),
            onTap: () {
              debugPrint("ListTile Tapped");
              navigateToDetail(this.taskList[position], 'Edit Task');
            },
          ),
        );
      },
    );
  }

  // Returns the priority color
  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;

      default:
        return Colors.yellow;
    }
  }

  // Returns the priority icon
  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;

      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  void _delete(BuildContext context, Task task) async {
    int result = await databaseHelper.deleteTask(task.id);
    if (result != 0) {
      _showSnackBar(context, 'Task Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Task task, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TaskDetail(task, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Task>> taskListFuture = databaseHelper.getTaskList();
      taskListFuture.then((taskList) {
        setState(() {
          this.taskList = taskList;
          this.count = taskList.length;
        });
      });
    });
  }
}
