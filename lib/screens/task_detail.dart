import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/task.dart';
import 'package:flutter_app/utils/database_helper.dart';
import 'package:intl/intl.dart';

class TaskDetail extends StatefulWidget {
  final String appBarTitle;
  final Task task;

  TaskDetail(this.task, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return TaskDetailState(this.task, this.appBarTitle);
  }
}

class TaskDetailState extends State<TaskDetail> {
  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Task task;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  TaskDetailState(this.task, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    titleController.text = task.title;
    descriptionController.text = task.description;

    return WillPopScope(
        onWillPop: () {
          moveToLastScreen();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(appBarTitle),
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  moveToLastScreen();
                }),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: titleController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in Title Text Field');
                      updateTitle();
                    },
                    decoration: InputDecoration(
                        labelText: 'Task Name',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: descriptionController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in Description Text Field');
                      updateDescription();
                    },
                    decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Save',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint("Save button clicked");
                              _save();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void updateTitle() {
    task.title = titleController.text;
  }

  void updateDescription() {
    task.description = descriptionController.text;
  }

  void _save() async {
    moveToLastScreen();

    task.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (task.id != null) {
      result = await helper.updateTask(task);
    } else {
      result = await helper.insertTask(task);
    }

    if (result != 0) {
      _showAlertDialog('Status', 'Task Saved Successfully');
    } else {
      _showAlertDialog('Status', 'Problem Saving Note');
    }
  }

  void _delete() async {
    moveToLastScreen();

    int result = await helper.deleteTask(task.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Task Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting ');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
