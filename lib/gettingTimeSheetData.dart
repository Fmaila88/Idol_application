import 'dart:ffi';

class GetTimeSheetData {
  String comment;
  String end;
  String id;
  int overtime;
  int normal;
  String start;

  GetTimeSheetData(
      this.comment, this.end, this.id, this.overtime, this.normal, this.start);

  getName() {
    return id;
  }

  @override
  String toString() {
    return '{ ${this.comment}, ${this.end},${this.id} }'
        '{ ${this.start}, ${this.overtime},${this.normal}, }';
  }
}
