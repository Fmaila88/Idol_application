import 'dart:ffi';

class ListTimeSheet {
  String createdDate;
  String id;
  int normalHours;
  int overtime;

  ListTimeSheet(
    this.createdDate,
    this.id,
    this.normalHours,
    this.overtime,
  );

  getName() {
    return id;
  }

  @override
  String toString() {
    return '{ ${this.createdDate}, ${this.id} }'
        '{ ${this.normalHours}, ${this.overtime} }';
  }
}
