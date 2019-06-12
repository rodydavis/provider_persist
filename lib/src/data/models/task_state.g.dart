// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskState _$TaskStateFromJson(Map<String, dynamic> json) {
  return TaskState(
      tasks: (json['tasks'] as List)
          .map((e) => Task.fromJson(e as Map<String, dynamic>))
          .toList());
}

Map<String, dynamic> _$TaskStateToJson(TaskState instance) =>
    <String, dynamic>{'tasks': instance.tasks.map((e) => e.toJson()).toList()};
