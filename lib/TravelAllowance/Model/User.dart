
import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class User {
  String firstName;
  String lastName;

  User(this.firstName, this.lastName);

  factory User.fromJson(Map<String,dynamic> json)=>_$UserFromJson(json);
  Map<String,dynamic> toJson()=>_$UserToJson(this);
}