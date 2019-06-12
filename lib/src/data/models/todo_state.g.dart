// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoState _$TodoStateFromJson(Map<String, dynamic> json) {
  return TodoState(
      tasks: (json['tasks'] as List)
          .map((e) => ToDo.fromJson(e as Map<String, dynamic>))
          .toList());
}

Map<String, dynamic> _$TodoStateToJson(TodoState instance) =>
    <String, dynamic>{'tasks': instance.tasks};
