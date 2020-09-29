import 'dart:ffi';

class Tasking {
  String id;
  String createDate;
  String dueDate;
  String description;
  String status;
  String profilePicture;

  Tasking(this.id,this.createDate, this.dueDate,this.description,this.status,this.profilePicture);

  getName(){
    return id;
  }

  @override
  String toString() {
    return '{  ${this.id} }' '{ ${this.createDate}, ${this.dueDate} }' '{ ${this.description}, }' '{ ${this.status}, ' '{${this.profilePicture}';
  }
}