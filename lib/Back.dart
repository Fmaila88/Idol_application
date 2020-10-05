class Back {
  String startTime;
  String endTime;
  String comments;
  String currentDate;

  Back({this.startTime, this.endTime, this.comments, this.currentDate});

  String getStartTime() {
    //this.startDate = time;
    return this.startTime;
  }

  String getendTime() {
    return this.endTime;
  }

  String getcomments() {
    return this.comments;
  }
}
