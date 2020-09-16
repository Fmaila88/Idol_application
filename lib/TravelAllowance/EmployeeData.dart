import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';


class EmployeeData {
  String user;
  String id;
  String startKm;
  String endKm;
  String travelDate;
  String comment;
  final DateFormat dateformat = DateFormat('dd MMMM YYYY');

  EmployeeData(this.user, this.id, this.startKm, this.endKm, this.travelDate, this.comment);

  getName(){
    return user;
  }

  convertDateFromString() {
    DateTime todayDate = DateTime.parse(this.travelDate);
    return formatDate(todayDate, [dd, ' ', MM, ' ', yyyy]);
  }

  @override
  String toString() {
    return '{ ${this.user}, ${this.id} }' '{ ${this.startKm}, ${this.endKm} }' '{ ${this.travelDate}, ${this.comment} }';
  }

}