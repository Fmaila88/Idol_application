import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';

class ListEmp {
  final DateFormat dateformat = DateFormat('dd MMMM YYYY');
  String firstName;
// String lastName;
  String createDate;
  ListEmp(this.firstName, this.createDate);
  String getFirstName() {
    return firstName;
  }

  convertDateFromString() {
    DateTime todayDate = DateTime.parse(this.createDate);
    return formatDate(todayDate, [MM, ' ', yyyy]);
  }
  // String getLastName() {
  //   return lastName;
  // }

  @override
  String toString() {
    return '  ${this.createDate} ${this.firstName}';
  }
}
