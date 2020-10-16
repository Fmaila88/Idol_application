


import 'package:json_annotation/json_annotation.dart';
part 'Company.g.dart';


@JsonSerializable()
class Company{

  String id;
  String name;
  String createDate;


  Company({
    this.createDate,
    this.id,
    this.name
  });

  factory Company.fromJson(Map<String,dynamic> json)=>_$CompanyFromJson(json);
  Map<String,dynamic> toJson()=>_$CompanyToJson(this);

}
