

class PerformanceAppraisals {
  String firstName;
  String createDate;
  String status;


  PerformanceAppraisals(this.firstName, this.createDate,this.status,);

  getName(){
    return firstName;
  }

  getCreateDate(){
    return createDate;
  }

  getStatus(){
    return status;
  }

  @override
  String toString() {
    return '{ ${this.firstName}, ${this.createDate} }' '{ ${this.status}';
  }

  static elementAt(int index) {}

  static void add(Type performanceAppraisals) {}
}
