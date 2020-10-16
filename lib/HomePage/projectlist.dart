//import 'dart:ffi';
//
//class ProjectList {
//  String name;
//  String id;
//  String createDate;
//  String endDate;
//  String description;
//  //double budget;
//  String status;
//  String logo;
//  Map createdBy;
//  Map manager;
//  List observers;
//  List members;
//  Map company;
//  String attachments;
//
//  ProjectList({this.name, this.id,this.createDate, this.endDate,this.description, this.status,this.logo, this.createdBy,
//      this.manager, this.observers,this.members,this.company, this.attachments,});
//
//  factory ProjectList.fromJson(Map<String,dynamic> json){
//    return ProjectList(
//
//      id: json['id'] as String,
//      name: json['name'] as String,
//      createDate: json['createDate'] as String,
//      endDate: json['endDate'] as String,
//      description: json['description'] as String,
//      status: json['status'] as String,
//      logo: json['logo'] as String,
//      createdBy: json['createdBy'] as Map,
//      manager: json['manager'] as Map,
//      observers: json['observers'] as List,
//      members: json['members'] as List,
//      attachments: json['attachments'] as String,
//
//    );
//  }
//
//  getName(){
//    return name;
//  }
//
//  @override
//  String toString() {
//    return '{ ${this.name}, ${this.id} }' '{ ${this.createDate}, ${this.endDate} }' '{ ${this.description},  }' '{ ${this.status}, '
//        '${this.createdBy} }' '{ ${this.manager}, ${this.observers} }' '{ ${this.members}, ${this.company} }' '{${this.attachments}' '{${this.logo}';
//  }
//}