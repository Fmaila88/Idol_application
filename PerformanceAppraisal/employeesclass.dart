class Employees {
  String firstName;
  String lastName;

  Employees(this.firstName, this.lastName);

  String getFirstName() {
    return firstName;
  }

  String getLastName() {
    return lastName;
  }

  @override
  String toString() {
    return ' ${this.firstName} ${this.lastName}';
  }
}
