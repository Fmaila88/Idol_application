import 'package:json_annotation/json_annotation.dart';

import 'Employee/User.dart';
part 'EmployeeData.g.dart';


@JsonSerializable()
class EmployeeData {
  final String Id;
  String startKm;
  String endKm;
  String travelDate;
  String comment;
  String status;
  String ratePerKm;
  User username;

  EmployeeData(this.Id, this.startKm, this.endKm, this.status, this.ratePerKm, this.travelDate, this.comment,this.username);

  //retrive data
  factory EmployeeData.fromJson(Map<String,String> json)=>_$EmployeeDataFromJson(json);
  Map<String,String> toJson()=>_$EmployeeDataToJson(this);


}