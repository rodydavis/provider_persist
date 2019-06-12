import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:localstorage/localstorage.dart';

import '../classes/index.dart';

part 'todo_state.g.dart';

class TodoProvider extends ChangeNotifier {
  TodoState _state;
  final String _stateKey = 'state';
  final _storage = LocalStorage('todo-state');

  void init() async {
    await _storage.ready;

    final _data = _storage.getItem(_stateKey);

    try {
      if (_data != null) {
        _state = TodoState.fromJson(json.decode(_data));
      }
    } catch (e) {
      print('Error Loading Todo State: $e');
    }

    if (_data == null) {
      _state = TodoState(tasks: []);
    }
    notifyListeners();
  }

  List<ToDo> get tasks => _state?.tasks;

  void addTask(ToDo value) {
    _state.tasks.add(value);
    notifyListeners();
    _saveState();
  }

  void editTask(int index, ToDo value) {
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

@JsonSerializable(nullable: false)
class TodoState {
  TodoState({this.tasks});

  factory TodoState.fromJson(Map<String, dynamic> json) =>
      _$TodoStateFromJson(json);

  List<ToDo> tasks;

  Map<String, dynamic> toJson() => _$TodoStateToJson(this);
}
