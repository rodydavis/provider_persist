// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToDo _$ToDoFromJson(Map<String, dynamic> json) {
  return ToDo(
      name: json['name'] as String,
      active: json['active'] as bool,
      dataCreated: DateTime.parse(json['dataCreated'] as String));
}

Map<String, dynamic> _$ToDoToJson(ToDo instance) => <String, dynamic>{
      'name': instance.name,
      'active': instance.active,
      'dataCreated': instance.dataCreated.toIso8601String()
    };
