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
