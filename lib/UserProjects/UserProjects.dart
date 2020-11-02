
import 'dart:convert';
import 'ProjectList.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:App_idolconsulting/UserProjects/CreatedBy.dart';
import 'Company.dart';
import 'Manager.dart';

part 'UserProjects.g.dart';

@JsonSerializable()
class UserProjects{

  String name;
  String id;
  String createDate;
  String endDate;
  String description;
  String status;
  String logo;
  Manager manager;
  CreatedBy createdBy;
  Company company;

  UserProjects({

    this.name,
    this.id,
    this.createDate,
    this.endDate,
    this.description,
    this.status,
    this.logo,
    this.createdBy,
    this.manager,
    this.company
  });

   //retrive data
   factory UserProjects.fromJson(Map<String,dynamic> json)=>_$UserProjectsFromJson(json);
   Map<String,dynamic> toJson()=>_$UserProjectsToJson(this);

}

