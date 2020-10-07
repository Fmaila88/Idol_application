import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';

class ListEmp {
  final DateFormat dateformat = DateFormat('dd MMMM YYYY');
  String user;
  String createDate;

  ListEmp(this.user, this.createDate);

  convertDateFromString() {
    DateTime todayDate = DateTime.parse(this.createDate);
    return formatDate(todayDate, [MM, ' ', yyyy]);
  }
}
