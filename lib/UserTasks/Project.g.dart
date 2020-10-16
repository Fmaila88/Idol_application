// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) {
  return Project(
    name: json['name'] as String,
    id: json['id'] as String,
    createDate: json['createDate'] as String,
    endDate: json['endDate'] as String,
    description: json['description'] as String,
    status: json['status'] as String,
    budget: (json['budget'] as num)?.toDouble(),
    startDate: json['startDate'] as String,
    logo: json['logo'] as String,
  );
}

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'createDate': instance.createDate,
      'endDate': instance.endDate,
      'description': instance.description,
      'status': instance.status,
      'budget': instance.budget,
      'startDate': instance.startDate,
      'logo': instance.logo,
    };
