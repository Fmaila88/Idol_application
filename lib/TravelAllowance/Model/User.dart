
import 'package:App_idolconsulting/employees/models/employee.dart';
import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class User {
  String id;
  String firstName;
  String lastName;
  Address address;
  Company company;

  User(this.firstName, this.lastName);

  factory User.fromJson(Map<String,dynamic> json)=>_$UserFromJson(json);
  Map<String,dynamic> toJson()=>_$UserToJson(this);
}