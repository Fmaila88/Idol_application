import 'dart:ffi';

class Days {
  String id;
  String employee;
  String startDate;
  String endDate;
  String totalDays;


  Days(this.id,this.employee, this.endDate,this.startDate, this.totalDays);

  getName(){
    return id;
  }

  @override
  String toString() {
    return '{  ${this.id} }' '{ ${this.employee}, ${this.endDate} }' '{ ${this.startDate}, ${this.totalDays} }';
  }
}