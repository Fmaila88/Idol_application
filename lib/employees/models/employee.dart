// To parse this JSON data, do
//
//     final employee = employeeFromJson(jsonString);
import 'dart:convert';

List<Employee> employeeFromJson(List data) {
  return List<Employee>.from(data.map((item) => Employee.fromJson(item)));
}

String employeeToJson(Employee data) => json.encode(data.toJson());

class Employee {
  String id;
  String createDate;
  ProfilePicture profilePicture;
  String firstName;
  String lastName;
  dynamic idNumber;
  String contactNumber;
  dynamic employeeNumber;
  String password;
  String email;
  dynamic address;
  List<String> roles;
  Position position;
  dynamic manager;
  dynamic accountManager;
  int studyLeaveDays;
  int nonDeductiveLeave;
  int annualLeaveDays;
  int sickLeaveDays;
  int familyResponsibility;
  Company company;

  Employee({
    this.id,
    this.createDate,
    this.profilePicture,
    this.firstName,
    this.lastName,
    this.idNumber,
    this.contactNumber,
    this.employeeNumber,
    this.password,
    this.email,
    this.address,
    this.roles,
    this.position,
    this.manager,
    this.accountManager,
    this.studyLeaveDays,
    this.nonDeductiveLeave,
    this.annualLeaveDays,
    this.sickLeaveDays,
    this.familyResponsibility,
    this.company,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        createDate: json["createDate"],
        profilePicture: json["profilePicture"] == null
            ? null
            : ProfilePicture.fromJson(json["profilePicture"]),
        firstName: json["firstName"],
        lastName: json["lastName"],
        idNumber: json["idNumber"],
        contactNumber: json["contactNumber"],
        employeeNumber: json["employeeNumber"],
        password: json["password"],
        email: json["email"],
        address: json["address"],
        roles: json["roles"] == null
            ? null
            : List<String>.from(json["roles"].map((x) => x)),
        position: json["position"] == null
            ? null
            : Position.fromJson(json["position"]),
        manager: json["manager"],
        accountManager: json["accountManager"],
        studyLeaveDays: json["studyLeaveDays"],
        nonDeductiveLeave: json["nonDeductiveLeave"],
        annualLeaveDays: json["annualLeaveDays"],
        sickLeaveDays: json["sickLeaveDays"],
        familyResponsibility: json["familyResponsibility"],
        company:
            json["company"] == null ? null : Company.fromJson(json["company"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createDate": createDate,
        "profilePicture":
            profilePicture == null ? null : profilePicture.toJson(),
        "firstName": firstName,
        "lastName": lastName,
        "idNumber": idNumber,
        "contactNumber": contactNumber,
        "employeeNumber": employeeNumber,
        "password": password,
        "email": email,
        "address": address,
        "roles": roles == null ? null : List<dynamic>.from(roles.map((x) => x)),
        "position": position == null ? null : position.toJson(),
        "manager": manager,
        "accountManager": accountManager,
        "studyLeaveDays": studyLeaveDays,
        "nonDeductiveLeave": nonDeductiveLeave,
        "annualLeaveDays": annualLeaveDays,
        "sickLeaveDays": sickLeaveDays,
        "familyResponsibility": familyResponsibility,
        "company": company == null ? null : company.toJson(),
      };
  @override
  String toString() {
    return "Employee{id:$id,employeeNumber:$employeeNumber firstName:$firstName, lastName:$lastName,company:$company,position:$position,roles:$roles,annualLeaveDays:$annualLeaveDays,sickLeaveDays:$sickLeaveDays,familyResponsibility:$familyResponsibility,contactNumber:$contactNumber,email:$email,password:$password}";
  }
}

class Company {
  String createDate;
  String id;
  String name = "Idol Consulting";
  Address address;
  ProfilePicture logo;
  Employee accountManager;
  String description;

  Company({
    this.createDate,
    this.id,
    this.name,
    this.address,
    this.logo,
    this.accountManager,
    this.description,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        createDate: json["createDate"],
        id: json["id"],
        name: json["name"],
        address: Address.fromJson(json["address"]),
        logo: ProfilePicture.fromJson(json["logo"]),
        accountManager: Employee.fromJson(json["accountManager"]),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "createDate": createDate,
        "id": id,
        "name": name,
        "address": address.toJson(),
        "logo": logo.toJson(),
        "accountManager": accountManager.toJson(),
        "description": description,
      };
}

class Address {
  dynamic line1;
  dynamic line2;
  dynamic province;
  dynamic country;
  dynamic latitude;
  dynamic longitude;
  String contactNumber;
  String email;

  Address({
    this.line1,
    this.line2,
    this.province,
    this.country,
    this.latitude,
    this.longitude,
    this.contactNumber,
    this.email,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        line1: json["line1"],
        line2: json["line2"],
        province: json["province"],
        country: json["country"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        contactNumber: json["contactNumber"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "line1": line1,
        "line2": line2,
        "province": province,
        "country": country,
        "latitude": latitude,
        "longitude": longitude,
        "contactNumber": contactNumber,
        "email": email,
      };
}

class ProfilePicture {
  String id;
  String name;
  String contentType;
  dynamic content;

  ProfilePicture({
    this.id,
    this.name,
    this.contentType,
    this.content,
  });

  factory ProfilePicture.fromJson(Map<String, dynamic> json) => ProfilePicture(
        id: json["id"],
        name: json["name"],
        contentType: json["contentType"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "contentType": contentType,
        "content": content,
      };
}

class Position {
  String id;
  String name;

  Position({
    this.id,
    this.name,
  });

  factory Position.fromJson(Map<String, dynamic> json) => Position(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
