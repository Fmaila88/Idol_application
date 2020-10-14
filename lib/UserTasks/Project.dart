


import 'package:json_annotation/json_annotation.dart';

part 'Project.g.dart';

@JsonSerializable()
class Project{

  String name;
  String id;
  String createDate;
  String endDate;
  String description;
  String status;
  String budget;
  String startDate;
  String logo;


  Project({
    this.name,
    this.id,
    this.createDate,
    this.endDate,
    this.description,
    this.status,
    this.budget,
    this.startDate,
    this.logo

  });

  factory Project.fromJson(Map<String,dynamic> json)=>_$ProjectFromJson(json);
  Map<String,dynamic> toJson()=>_$ProjectToJson(this);

}