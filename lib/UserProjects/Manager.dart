


import 'package:json_annotation/json_annotation.dart';

part 'Manager.g.dart';

@JsonSerializable()
class Manager{

  String firstName;
  String lastName;


  Manager({
   this.firstName,
   this.lastName

  });

  factory Manager.fromJson(Map<String,dynamic> json)=>_$ManagerFromJson(json);
  Map<String,dynamic> toJson()=>_$ManagerToJson(this);

}