import 'package:flutter/material.dart';
import 'package:provider_persist/src/data/classes/index.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({this.task});
  final Task task;

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget?.task == null ? 'New Task' : 'Edit Task'),
      ),
    );
  }
}
