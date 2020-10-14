import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'Project.dart';
part 'UserTasks.g.dart';

@JsonSerializable()
class UserTasks{

  String name;
  String id;
  String createDate;
  String endDate;
  String description;
  String status;
  String budget;
  String startDate;
  Project project;



  UserTasks({

    this.name,
    this.id,
    this.createDate,
    this.endDate,
    this.description,
    this.status,
    this.budget,
    this.startDate,
    this.project
  });

  //retrive data
  factory UserTasks.fromJson(Map<String,dynamic> json)=>_$UserTasksFromJson(json);
  Map<String,dynamic> toJson()=>_$UserTasksToJson(this);

}