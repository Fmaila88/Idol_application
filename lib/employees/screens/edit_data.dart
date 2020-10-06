import "package:flutter/material.dart";
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:App_idolconsulting/employees_main.dart';

class EditData extends StatefulWidget {
  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("EDIT EMPLOYEE DATA"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Expanded(
            child: new Column(
              children: [
                new TextField(
                  decoration: new InputDecoration(
                      hintText: "Employee Number",
                      labelText: "Employee Number"),
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
                new TextField(
                  decoration: new InputDecoration(
                      hintText: "Company", labelText: "Company"),
                  controller: controllerCompany,
                ),
                new TextField(
                  decoration: new InputDecoration(
                      hintText: "Position", labelText: "Position"),
                  controller: controllerPosition,
                ),
                new TextField(
                  decoration:
                      new InputDecoration(hintText: "Role", labelText: "Role"),
                  controller: controllerRole,
                ),
                new TextField(
                  decoration: new InputDecoration(
                      hintText: "Annual Leave Days",
                      labelText: "Annual Leave Days"),
                  keyboardType: TextInputType.number,
                  controller: controllerAnnLeaveDays,
                ),
                new TextField(
                  decoration: new InputDecoration(
                      hintText: "Sick Leave Days",
                      labelText: "Sick Leave Days"),
                  keyboardType: TextInputType.number,
                  controller: controllerSickLeaveDays,
                ),
                new TextField(
                  decoration: new InputDecoration(
                      hintText: "Family Responsibility",
                      labelText: "Family Responsibility"),
                  keyboardType: TextInputType.number,
                  controller: controllerFamilyResponsibility,
                ),
                new TextField(
                  decoration: new InputDecoration(
                      hintText: "Contact Number", labelText: "Contact Number"),
                  controller: controllerContactNumber,
                ),
                new TextField(
                  decoration: new InputDecoration(
                      hintText: "Email", labelText: "Email"),
                  controller: controllerEmail,
                ),
                new TextField(
                  decoration: new InputDecoration(
                      hintText: "Password", labelText: "Password"),
                  controller: controllerPassword,
                ),
                Padding(padding: EdgeInsets.all(10.0)),
                new RaisedButton(
                  child: new Text("EDIT EMPLOYEE"),
                  color: Colors.blue,
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    String stringValue = prefs.getString('userToken');
                    Map<String, String> headers = {
                      "content-type": "application/json",
                      "Accept": "application/json",
                      "X_TOKEN": "$stringValue",
                    };

                    var url = "https://app.idolconsulting.co.za/idols/users";
                    final body = jsonEncode({
                      "employeeNumber": controllerEmpNumber.text,
                      "firstName": controllerFirstName.text,
                      "lastName": controllerLastName.text,
                      "company": {
                        "id": "5ba3acb0c391b566c3c51e66",
                        "name": "Idol Consulting",
                      },
                      "position": {
                        "id": "5f350574c391b51061db90e9",
                        "name": "App Developer",
                      },
                      "roles": [
                        controllerRole.text,
                      ],
                      "annualLeaveDays": int.parse(controllerAnnLeaveDays.text),
                      "sickLeaveDays": int.parse(controllerSickLeaveDays.text),
                      "familyResponsibility":
                          int.parse(controllerFamilyResponsibility.text),
                      "contactNumber": controllerContactNumber.text,
                      "email": controllerEmail.text,
                      "password": controllerPassword.text,
                    });
                    final response =
                        await http.put(url, headers: headers, body: body);

                    setState(() {
                      if (response.statusCode == 200) {
                        print(response.body);
                        print(jsonDecode(body));
                        //print(stringValue);
                      }
                    });
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new EmployeesHome()));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
