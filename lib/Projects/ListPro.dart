import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';

class ListPro {
  final DateFormat dateformat = DateFormat('dd MMMM YYYY');

  final String Id;
  String createDate;
  String name;
  String endDate;
  //String name;
  String budget;
  String status;
  String manager;

  ListPro(this.Id, this.createDate, this.name, this.endDate, this.budget,
      this.status, this.manager);

  convertDateFromString() {
    DateTime todayDate = DateTime.parse(this.createDate);
    return formatDate(todayDate, [MM, ' ', yyyy]);
  }

  // convertDateString() {
  //   DateTime todayDate = DateTime.parse(this.endDate);
  //   return formatDate(todayDate, [MM, ' ', yyyy]);
  // }
}
