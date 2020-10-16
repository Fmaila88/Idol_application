// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Tasks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tasks _$TasksFromJson(Map<String, dynamic> json) {
  return Tasks(
    description: json['description'] as String,
    dueDate: json['dueDate'] as String,
    project: json['project'] == null
        ? null
        : Projector.fromJson(json['project'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TasksToJson(Tasks instance) => <String, dynamic>{
      'description': instance.description,
      'dueDate': instance.dueDate,
      'project': instance.project,
    };
