

class EmployeeList{


  String firstName;
  String lastName;


  EmployeeList({

  this.firstName,
  this.lastName,
  });


 factory EmployeeList.fromJson(Map<String,dynamic> json){

   return EmployeeList(

     firstName: json['firstName'] as String,
     lastName: json['lastName'] as String,

   );

 }


}