import 'package:json_annotation/json_annotation.dart';

part 'Allowance_Model.g.dart';

@JsonSerializable()
class Allowance_Model {
  String id;
  String userId;
  String firstName;
  String lastName;
  double startKm;
  double endKm;
  double ratePerKm;
  String status;
  String comment;
  String travelDate;

  Allowance_Model({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
    this.startKm,
    this.endKm,
    this.ratePerKm,
    this.status,
    this.comment,
    this.travelDate,
  });

  factory Allowance_Model.fromJson(Map<String,dynamic> json)=>_$Allowance_ModelFromJson(json);
  Map<String,dynamic> toJson()=>_$Allowance_ModelToJson(this);

}