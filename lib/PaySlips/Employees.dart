class Employees {
  String firstName;
  String lastName;

  Employees(this.firstName, this.lastName);

  @override
  String toString() {
    return '${this.firstName} ${this.lastName}';
  }
}
