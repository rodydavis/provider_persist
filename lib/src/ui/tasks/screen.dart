import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/classes/index.dart';
import '../../data/models/index.dart';
import '../index.dart';

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Task Manager'),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, model, child) {
          if (model?.tasks == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (model.tasks.isEmpty) {
            return Center(
              child: Text('No Tasks Found'),
            );
          }
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemCount: model.tasks.length,
            itemBuilder: (context, index) {
              final _item = model.tasks[index];
              return ListTile(
                title: Text(_item.name),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => model.deleteTask(index),
                ),
                onTap: () => _editTask(context, _item, index),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _addTask(context),
      ),
    );
  }

  void _addTask(BuildContext context) async {
    final _task = await Navigator.push<Task>(
        context,
        MaterialPageRoute(
          builder: (_) => EditTaskScreen(),
          fullscreenDialog: true,
        ));

    if (_task != null) {
      final _model = Provider.of<TaskProvider>(context);
      _model.addTask(_task);
    }
  }

  void _editTask(BuildContext context, Task task, int index) async {
    final _task = await Navigator.push<Task>(
        context,
        MaterialPageRoute(
          builder: (_) => EditTaskScreen(task: task),
          fullscreenDialog: false,
        ));

    if (_task != null) {
      final _model = Provider.of<TaskProvider>(context);
      _model.editTask(index, _task);
    }
  }
}
