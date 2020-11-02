// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Allowance_Model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Allowance_Model _$Allowance_ModelFromJson(Map<String, dynamic> json) {
  return Allowance_Model(
    id: json['id'] as String,
    userId:  json['user']['id'] as String,
    firstName: json['user']['firstName'] as String,
    lastName: json['user']['lastName'] as String,
    startKm: (json['startKm'] as num)?.toDouble(),
    endKm: (json['endKm'] as num)?.toDouble(),
    ratePerKm: (json['ratePerKm'] as num)?.toDouble(),
    status: json['status'] as String,
    comment: json['comment'] as String,
    travelDate: json['travelDate'] as String,
  );
}

Map<String, dynamic> _$Allowance_ModelToJson(Allowance_Model instance) =>
    <String, dynamic>{
      'id': instance.id,
      // 'user': instance.user,
      'startKm': instance.startKm,
      'endKm': instance.endKm,
      'ratePerKm': instance.ratePerKm,
      'status': instance.status,
      'comment': instance.comment,
      'travelDate': instance.travelDate,
    };
