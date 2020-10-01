import 'dart:ffi';

class Days {
  String id;
  String employee;
  String startDate;
  String end;
  String totalDays;


  Days(this.id,this.employee, this.end,this.startDate, this.totalDays);


  @override
  String toString() {
    return '{${this.id} }''{ ${this.employee}, ${this.end} }' '{ ${this.startDate}, ${this.totalDays} }';
  }
}