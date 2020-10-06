import 'dart:ffi';
import 'package:date_format/date_format.dart';

class Perform {
  String id;
  String date;
  String employee;
  String status;


  Perform(this.id,this.employee, this.date, this.status);

  getName() {
    return id;
  }
  @override
  String toString() {
    return '{  ${this.id} }' '{ ${this.employee}, ${this.status} }' '{ ${this.date} }';
  }
  convertDateFromString() {
    DateTime todayDate = DateTime.parse(this.date);
    return formatDate(todayDate, [MM, DD,' ', yyyy]);
  }
}