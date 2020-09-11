import 'dart:ffi';

class EmployeeData {
  String user;
  String id;
  String startKm;
  String endKm;
  String travelDate;
  String comment;

  EmployeeData(this.user, this.id, this.startKm, this.endKm, this.travelDate, this.comment);

  getName(){
    return user;
  }

  @override
  String toString() {
    return '{ ${this.user}, ${this.id} }' '{ ${this.startKm}, ${this.endKm} }' '{ ${this.travelDate}, ${this.comment} }';
  }

}