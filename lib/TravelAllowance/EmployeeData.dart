import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';


class EmployeeData {
  String user;
  String startKm;
  String endKm;
  String travelDate;
  String comment;
  final DateFormat dateformat = DateFormat('dd MMMM YYYY');

  EmployeeData(this.user, this.startKm, this.endKm, this.travelDate);

  convertDateFromString() {
    DateTime todayDate = DateTime.parse(this.travelDate);
    return formatDate(todayDate, [dd, ' ', MM, ' ', yyyy]);
  }
}