



import 'package:json_annotation/json_annotation.dart';

part 'Projector.g.dart';
@JsonSerializable()
class Projector{


  String name;
  String description;

  Projector({

    this.name,
    this.description

  });

  factory Projector.fromJson(Map<String,dynamic> json)=>_$ProjectorFromJson(json);
  Map<String,dynamic> toJson()=>_$ProjectorToJson(this);


}
