import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
        _state = await _fetchState(_data);
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

  void dummyData() async {
    final _now = DateTime.now();
    final _list = List.generate(
        20000,
        (index) => Task(
              name: 'Task: $index',
              dataCreated: _now,
            ));
    _state.tasks = _list;
    notifyListeners();
    _saveState();
  }

  void clearAll() {
    _state.tasks.clear();
    notifyListeners();
    _saveState();
  }

  void _saveState() async => await _storage.setItem(_stateKey, _state.toJson());
}

Future<TaskState> _fetchState(Map<String, dynamic> data) async {
  final _data = json.encode(data);
  return compute(_parseState, _data);
}

TaskState _parseState(String data) {
  return TaskState.fromJson(json.decode(data));
}

@JsonSerializable(nullable: false, explicitToJson: true)
class TaskState {
  TaskState({this.tasks});

  factory TaskState.fromJson(Map<String, dynamic> json) =>
      _$TaskStateFromJson(json);

  List<Task> tasks;

  Map<String, dynamic> toJson() => _$TaskStateToJson(this);
}
