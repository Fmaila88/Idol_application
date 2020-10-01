import 'dart:ffi';

class Perform {
  String id;
  String date;
  String employee;
  String status;


  Perform(this.id,this.employee, this.date, this.status);

  getName(){
    return id;


class PerformanceAppraisals {
  String firstName;
  String createDate;
  String status;


  PerformanceAppraisals(this.firstName, this.createDate,this.status,);

  getName(){
    return firstName;
  }

  getCreateDate(){
    return createDate;
  }

  getStatus(){
    return status;
  }

  @override
  String toString() {
    return '{  ${this.id} }' '{ ${this.employee}, ${this.status} }' '{ ${this.date} }';
  }
}