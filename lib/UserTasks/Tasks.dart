


import 'package:json_annotation/json_annotation.dart';

import 'Projector.dart';

part 'Tasks.g.dart';
@JsonSerializable()
class Tasks{

  String description;
  String dueDate;
  Projector project;


  Tasks({

   this.description,
   this.dueDate,
    this.project

});

  factory Tasks.fromJson(Map<String,dynamic> json)=>_$TasksFromJson(json);
  Map<String,dynamic> toJson()=>_$TasksToJson(this);


}