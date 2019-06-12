import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable(nullable: false)
class ToDo {
  final String name;
  final bool active;
  final DateTime dataCreated;
  ToDo({this.name, this.active, this.dataCreated});

  factory ToDo.fromJson(Map<String, dynamic> json) => _$ToDoFromJson(json);
  
  Map<String, dynamic> toJson() => _$ToDoToJson(this);
}
