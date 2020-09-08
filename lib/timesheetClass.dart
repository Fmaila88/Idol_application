import 'dart:convert';

import 'package:flutter/material.dart';

class Timesheet {
  String comment;
  String end;
  String endTime;
  String start;
  String startTime;
  Timesheet({
    this.comment,
    this.end,
    this.endTime,
    this.start,
    this.startTime,
  });

  factory Timesheet.fromJson(Map<String, dynamic> json) {
    return Timesheet(
      comment: json['comment'],
      end: json['end'],
      endTime: json['endTime'],
      start: json['start'],
      startTime: json['startTime'],
    );
  }
}

//  Timesheet copyWith({
//     String comment,
//     var end,
//     var endTime,
//     var start,
//     var startTime,
//   }) {
//     return Timesheet(
//       comment: comment ?? this.comment,
//       end: end ?? this.end,
//       endTime: endTime ?? this.endTime,
//       start: start ?? this.start,
//       startTime: startTime ?? this.startTime,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'comment': comment,
//       'end': end?.toMap(),
//       'endTime': endTime?.toMap(),
//       'start': start?.toMap(),
//       'startTime': startTime?.toMap(),
//     };
//   }

//   factory Timesheet.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return Timesheet(
//       // //comment: var.fromMap(map['comment']),
//       // end: var.fromMap(map['end']),
//       // endTime: var.fromMap(map['endTime']),
//       // start: var.fromMap(map['start']),
//       // startTime: var.fromMap(map['startTime']),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Timesheet.fromJson(String source) => Timesheet.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'timesheet(comment: $comment, end: $end, endTime: $endTime, start: $start, startTime: $startTime)';
//   }

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is Timesheet &&
//       o.comment == comment &&
//       o.end == end &&
//       o.endTime == endTime &&
//       o.start == start &&
//       o.startTime == startTime;
//   }

//   @override
//   int get hashCode {
//     return comment.hashCode ^
//       end.hashCode ^
//       endTime.hashCode ^
//       start.hashCode ^
//       startTime.hashCode;
//   }
