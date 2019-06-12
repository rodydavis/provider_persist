import 'package:flutter/material.dart';
import 'package:provider_persist/src/data/classes/index.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({this.task});
  final Task task;

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _name = TextEditingController();

  @override
  void initState() {
    if (widget?.task != null) {
      final _task = widget.task;
      _name.text = _task.name;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget?.task == null ? 'New Task' : 'Edit Task'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final _task = Task(
                name: _name.text,
                dataCreated: DateTime.now(),
              );
              Navigator.pop(context, _task);
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _name,
              decoration: InputDecoration(labelText: 'Task Name'),
            ),
          ],
        ),
      ),
    );
  }
}
