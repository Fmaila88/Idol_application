import 'dart:ffi';

class Project {
  String name;
  String id;
  String createDate;
  String endDate;
  String description;
  String status;
  //double budget;
  String logo;
  Map createdBy;
  Map manager;
  List observers;
  List members;
  Map company;
  String attachments;

  Project(this.name, this.id,this.createDate, this.endDate,this.description, this.status,this.logo, this.createdBy,
      this.manager, this.observers,this.members,this.company, this.attachments,
      );

  getName(){
    return name;
  }


  @override
  String toString() {
    return '{ ${this.name}, ${this.id} }' '{ ${this.createDate}, ${this.endDate} }' '{ ${this.description},' '{ ${this.status}, '
        '${this.createdBy} }' '{ ${this.manager}, ${this.observers} }' '{ ${this.members}, ${this.company} }' '{${this.attachments}' '{${this.logo}';
        //'{${this.budget}';
  }
}



class Tasks {
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

  Tasks(this.name,this.createDate, this.endDate, this.status,this.dueDate,
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