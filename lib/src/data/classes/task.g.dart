// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
      name: json['name'] as String,
      dataCreated: DateTime.parse(json['dataCreated'] as String),
      active: json['active'] as bool);
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'name': instance.name,
      'active': instance.active,
      'dataCreated': instance.dataCreated.toIso8601String()
    };
