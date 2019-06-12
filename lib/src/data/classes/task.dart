import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable(nullable: false)
class Task {
  final String name;
  final bool active;
  final DateTime dataCreated;
  Task({this.name, this.active, this.dataCreated});

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
