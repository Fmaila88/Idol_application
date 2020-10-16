import 'package:json_annotation/json_annotation.dart';
part 'User.g.dart';


@JsonSerializable()
class User {
  final String Id;
  String lastName;
  String firstName;


  User(this.firstName, this.Id, this.lastName);

  //retrive data
  factory User.fromJson(Map<String,String> json)=>_$UserFromJson(json);
  Map<String,String> toJson()=>_$UserToJson(this);
}