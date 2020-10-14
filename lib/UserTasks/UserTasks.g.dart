// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserTasks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTasks _$UserTasksFromJson(Map<String, dynamic> json) {
  return UserTasks(
    name: json['name'] as String,
    id: json['id'] as String,
    createDate: json['createDate'] as String,
    endDate: json['endDate'] as String,
    description: json['description'] as String,
    status: json['status'] as String,
    budget: json['budget'] as String,
    startDate: json['startDate'] as String,
    project: json['project'] == null
        ? null
        : Project.fromJson(json['project'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserTasksToJson(UserTasks instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'createDate': instance.createDate,
      'endDate': instance.endDate,
      'description': instance.description,
      'status': instance.status,
      'budget': instance.budget,
      'startDate': instance.startDate,
      'project': instance.project,
    };
