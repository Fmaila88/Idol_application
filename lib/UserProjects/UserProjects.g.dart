// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserProjects.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProjects _$UserProjectsFromJson(Map<String, dynamic> json) {
  return UserProjects(
    name: json['name'] as String,
    id: json['id'] as String,
    createDate: json['createDate'] as String,
    endDate: json['endDate'] as String,
    description: json['description'] as String,
    status: json['status'] as String,
    logo: json['logo'] as String,
    createdBy: json['createdBy'] == null
        ? null
        : CreatedBy.fromJson(json['createdBy'] as Map<String, dynamic>),
    manager: json['manager'] == null
        ? null
        : Manager.fromJson(json['manager'] as Map<String, dynamic>),
    company: json['company'] == null
        ? null
        : Company.fromJson(json['company'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserProjectsToJson(UserProjects instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'createDate': instance.createDate,
      'endDate': instance.endDate,
      'description': instance.description,
      'status': instance.status,
      'logo': instance.logo,
      'manager': instance.manager,
      'createdBy': instance.createdBy,
      'company': instance.company,
    };
