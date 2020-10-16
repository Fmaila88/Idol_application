
import 'Employee/User.dart';

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
}