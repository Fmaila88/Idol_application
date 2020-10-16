


import 'package:json_annotation/json_annotation.dart';
part 'CreatedBy.g.dart';


@JsonSerializable()
class CreatedBy{

  String id;
  String createDate;


  CreatedBy({
    this.createDate,
    this.id
  });

  factory CreatedBy.fromJson(Map<String,dynamic> json)=>_$CreatedByFromJson(json);
  Map<String,dynamic> toJson()=>_$CreatedByToJson(this);

}
