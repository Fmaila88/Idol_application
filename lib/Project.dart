import 'dart:ffi';

class Project {
  String name;
  String id;
  String createDate;
  String endDate;
  String description;
  double budget;
  String status;
  String logo;
  Map createdBy;
  Map manager;
  List observers;
  List members;
  Map company;
  String attachments;

  Project(this.name, this.id,this.createDate, this.endDate,this.description, this.budget,this.status,this.logo, this.createdBy,
      this.manager, this.observers,this.members,this.company, this.attachments,);

  getName(){
    return id;
  }

  @override
  String toString() {
    return '{ ${this.name}, ${this.id} }' '{ ${this.createDate}, ${this.endDate} }' '{ ${this.description}, ${this.budget} }' '{ ${this.status}, '
           '${this.createdBy} }' '{ ${this.manager}, ${this.observers} }' '{ ${this.members}, ${this.company} }' '{${this.attachments}' '{${this.logo}';
  }
}