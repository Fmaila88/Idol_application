class Back {
  String startTime;
  String endTime;
  String comments;
  String currentDate;
  String totalhours;

  Back(
      {this.startTime,
      this.endTime,
      this.comments,
      this.currentDate,
      this.totalhours});

  String getStartTime() {
    return this.startTime;
  }

  String getendTime() {
    return this.endTime;
  }

  String getcomments() {
    return this.comments;
  }

  String getcurrentDate() {
    return this.currentDate;
  }

  String gettotalhours() {
    return this.totalhours;
  }
}
