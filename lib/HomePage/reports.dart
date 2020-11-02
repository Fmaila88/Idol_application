import 'dart:ffi';

class Chart {
  String New;
  String Panding;
  String Done;

  Chart(this.New, this.Panding,this.Done,);

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
    return '{ ${this.New}, ${this.Panding} }' '{ ${this.Done}, ';
  }

  String getnew(){
    return this.New;
  }

  String getpedding(){
    return this.Panding;
  }

  String getdone(){
    return this.Done;
  }

}









class Indicator {
  String percent;

  Indicator(this.percent,);

//  factory Indicator.fromJson(Map<String,dynamic> json){
//    return Indicator(
//
//      percent: json['percent'] as String,
//
//    );
//  }

//  getName(){
//    return percent;
//  }

  @override
  String toString() {
    return '{ ${this.percent}, ';
  }
}
