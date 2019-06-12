# provider_persist

A Flutter Template to show how to persist provider.

## Getting Started

Example of how to persist UI state with [Provider](https://pub.dev/packages/provider).

## UI

``` dart
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

```

## Model

``` dart
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:localstorage/localstorage.dart';

import '../classes/index.dart';

part 'task_state.g.dart';

class TaskProvider extends ChangeNotifier {
  TaskState _state;
  final String _stateKey = 'state';
  final _storage = LocalStorage('Task-state');

  void init() async {
    await _storage.ready;

    final _data = _storage.getItem(_stateKey);

    try {
      if (_data != null) {
        _state = TaskState.fromJson(_data);
      }
    } catch (e) {
      print('Error Loading Task State: $e');
    }

    if (_data == null) {
      _state = TaskState(tasks: []);
    }
    notifyListeners();
  }

  List<Task> get tasks => _state?.tasks;

  void addTask(Task value) {
    _state.tasks.add(value);
    notifyListeners();
    _saveState();
  }

  void editTask(int index, Task value) {
    _state.tasks[index] = value;
    notifyListeners();
    _saveState();
  }

  void deleteTask(int index) {
    _state.tasks.removeAt(index);
    notifyListeners();
    _saveState();
  }

  void _saveState() async => await _storage.setItem(_stateKey, _state.toJson());
}

@JsonSerializable(nullable: false, explicitToJson: true)
class TaskState {
  TaskState({this.tasks});

  factory TaskState.fromJson(Map<String, dynamic> json) =>
      _$TaskStateFromJson(json);

  List<Task> tasks;

  Map<String, dynamic> toJson() => _$TaskStateToJson(this);
}

```

## Class

To update run: `flutter packages pub run build_runner watch  —delete-conflicting-outputs`

``` dart
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable(nullable: false)
class Task {
  final String name;
  final bool active;
  final DateTime dataCreated;
  Task({
    @required this.name,
    @required this.dataCreated,
    this.active: true,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}

```
