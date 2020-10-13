
class User {
  String firstName;
  String lastName;

  User(this.firstName, this.lastName);

  @override
  String toString() {
    return '${this.firstName} ${this.lastName}';
  }
}