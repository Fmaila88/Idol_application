import 'dart:ffi';

class Project {
  String name;
  String id;
  String createDate;
  String endDate;
  String description;
  //double budget;
  String status;
  String logo;
  Map createdBy;
  Map manager;
  List observers;
  List members;
  Map company;
  String attachments;

  Project(this.name, this.id,this.createDate, this.endDate,this.description, this.status,this.logo, this.createdBy,
      this.manager, this.observers,this.members,this.company, this.attachments,);

//  factory Project.fromJson(Map<String,dynamic> json){
//    return Project(
//
//      id: json['id'] as String,
//      name: json['name'] as String,
//      createDate: json['createDate'] as String,
//      endDate: json['endDate'] as String,
//      description: json['description'] as String,
//      status: json['status'] as String,
//      logo: json['logo'] as String,
////      createdBy: json['createdBy'] as Map,
////      manager: json['manager'] as Map,
////      observers: json['observers'] as List,
////      members: json['members'] as List,
////      attachments: json['attachments'] as String,
//
//    );
//  }

  getName(){
    return name;
  }

  @override
  String toString() {
    return '{ ${this.name}, ${this.id} }' '{ ${this.createDate}, ${this.endDate} }' '{ ${this.description},  }' '{ ${this.status}, '
           '${this.createdBy} }' '{ ${this.manager}, ${this.observers} }' '{ ${this.members}, ${this.company} }' '{${this.attachments}' '{${this.logo}';
  }
}

class Taskss {
  String name;
  String dueDate;
  String createDate;
  String endDate;
  //String description;
  String status;
//  double budget;
//
//  String logo;
//  Map createdBy;
//  Map manager;
//  List observers;
//  List members;
//  Map company;
//  String attachments;

  Taskss(this.name,this.createDate, this.endDate, this.status,this.dueDate,
      //this.status,this.logo, this.createdBy,
      // this.manager, this.observers,this.members,this.company, this.attachments,
      );

  getName(){
    return name;
  }

  @override
  String toString() {
    return '{ ${this.name}, ${this.createDate}, ${this.endDate} }' '{ ${this.status}, ''${this.dueDate} }'
    //'{ ${this.manager}, ${this.observers} }' '{ ${this.members}, ${this.company} }' '{${this.attachments}' '{${this.logo}'
        '';
  }
}