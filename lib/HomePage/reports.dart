import 'dart:ffi';

class Chart {
  String created;
  String panding;
  String done;


  Chart(this.created, this.panding,this.done,);


//  factory Chart.fromJson(Map<String,dynamic> json){
//    return Chart(
//
//      created: json['created'] as String,
//      panding: json['panding'] as String,
//      done: json['done'] as String,
//
//    );
//  }

//  getName(){
//    return name;
//  }

  @override
  String toString() {
    return '{ ${this.created}, ${this.panding} }' '{ ${this.done}, ';
  }
}
