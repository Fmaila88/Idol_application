import 'dart:ffi';

class Perform {
  String id;
  String date;
  String employee;
  String status;


  Perform(this.id,this.employee, this.date, this.status);

  getName(){
    return id;
  }

  @override
  String toString() {
    return '{  ${this.id} }' '{ ${this.employee}, ${this.status} }' '{ ${this.date} }';
  }
}