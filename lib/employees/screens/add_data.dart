import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:App_idolconsulting/employees/models/employee.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController controllerEmpNumber = new TextEditingController();
  TextEditingController controllerFirstName = new TextEditingController();
  TextEditingController controllerLastName = new TextEditingController();
  TextEditingController controllerCompany = new TextEditingController();
  TextEditingController controllerPosition = new TextEditingController();
  TextEditingController controllerRole = new TextEditingController();
  TextEditingController controllerAnnLeaveDays = new TextEditingController();
  TextEditingController controllerSickLeaveDays = new TextEditingController();
  TextEditingController controllerFamilyResponsibility =
      new TextEditingController();
  TextEditingController controllerContactNumber = new TextEditingController();
  TextEditingController controllerEmail = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();

  Future addData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('userToken');
    var url = "https://app.idolconsulting.co.za/idols/users";
    final body = jsonEncode({
      "employeeNumber": controllerEmpNumber.text,
      "firstName": controllerFirstName.text,
      "lastName": controllerLastName.text,
      // "company": {
      //   "name": controllerCompany.text,
      // },
      // "position": {"name": controllerPosition.text},
      // "roles": [controllerRole.text],
      // "annualLeaveDays": controllerAnnLeaveDays as int,
      // "sickLeaveDays": controllerSickLeaveDays as int,
      // "familyResponsibility": controllerFamilyResponsibility as int,
      // "contactNumber": controllerContactNumber.text,
      // "email": controllerEmail.text,
      // "password": controllerPassword.text,
    });
    final response = await http.put(url,
        headers: {
          "Accept": "application/json",
          "X_TOKEN": stringValue,
        },
        body: body);
    print(json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Add Employee"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Column(
            children: [
              new TextField(
                decoration: new InputDecoration(
                    hintText: "Employee Number", labelText: "Employee Number"),
                controller: controllerEmpNumber,
              ),
              new TextField(
                decoration: new InputDecoration(
                    hintText: "First Name", labelText: "First Name"),
                controller: controllerFirstName,
              ),
              new TextField(
                decoration: new InputDecoration(
                    hintText: "Last Name", labelText: "Last Name"),
                controller: controllerLastName,
              ),
              // new TextField(
              //   decoration: new InputDecoration(
              //       hintText: "Company", labelText: "Company"),
              //   controller: controllerCompany,
              // ),
              // new TextField(
              //   decoration: new InputDecoration(
              //       hintText: "Position", labelText: "Position"),
              //   controller: controllerPosition,
              // ),
              // new TextField(
              //   decoration:
              //       new InputDecoration(hintText: "Role", labelText: "Role"),
              //   controller: controllerRole,
              // ),
              // new TextField(
              //   decoration: new InputDecoration(
              //       hintText: "Annual Leave Days",
              //       labelText: "Annual Leave Days"),
              //   controller: controllerAnnLeaveDays,
              // ),
              // new TextField(
              //   decoration: new InputDecoration(
              //       hintText: "Sick Leave Days", labelText: "Sick Leave Days"),
              //   controller: controllerSickLeaveDays,
              // ),
              // new TextField(
              //   decoration: new InputDecoration(
              //       hintText: "Family Responsibility",
              //       labelText: "Family Responsibility"),
              //   controller: controllerFamilyResponsibility,
              // ),
              // new TextField(
              //   decoration: new InputDecoration(
              //       hintText: "Contact Number", labelText: "Contact Number"),
              //   controller: controllerContactNumber,
              // ),
              // new TextField(
              //   decoration:
              //       new InputDecoration(hintText: "Email", labelText: "Email"),
              //   controller: controllerEmail,
              // ),
              // new TextField(
              //   decoration: new InputDecoration(
              //       hintText: "Password", labelText: "Password"),
              //   controller: controllerPassword,
              // ),
              Padding(padding: EdgeInsets.all(10.0)),
              new RaisedButton(
                child: new Text("Add Employee"),
                color: Colors.blue,
                onPressed: () {
                  addData();
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
