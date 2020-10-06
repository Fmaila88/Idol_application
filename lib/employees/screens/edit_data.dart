import 'package:flutter/material.dart';
import 'package:App_idolconsulting/employees_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class EditData extends StatefulWidget {
  final List list;
  final int index;
  EditData({this.list, this.index});

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  TextEditingController controllerEmpNumber;
  TextEditingController controllerFirstName;
  TextEditingController controllerLastName;
  TextEditingController controllerCompany;
  TextEditingController controllerPosition;
  TextEditingController controllerRole;
  TextEditingController controllerAnnLeaveDays;
  TextEditingController controllerSickLeaveDays;
  TextEditingController controllerFamilyResponsibility;
  TextEditingController controllerContactNumber;
  TextEditingController controllerEmail;
  TextEditingController controllerPassword;

  void editEmployee() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('userToken');
    Map<String, String> headers = {
      "content-type": "application/json",
      "Accept": "application/json",
      "X_TOKEN": "$stringValue",
    };

    var url = "https://app.idolconsulting.co.za/idols/users";
    final body = jsonEncode({
      "id": widget.list[widget.index]['id'],
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
      "familyResponsibility": int.parse(controllerFamilyResponsibility.text),
      "contactNumber": controllerContactNumber.text,
      "email": controllerEmail.text,
      "password": controllerPassword.text,
    });
    final response = await http.put(url, headers: headers, body: body);

    setState(() {
      if (response.statusCode == 200) {
        print(response.body);
        print(jsonDecode(body));
        //print(stringValue);
      }
    });
    Navigator.pop(context);
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new EmployeesHome()));
  }

  @override
  void initState() {
    controllerEmpNumber = new TextEditingController(
        text: "${widget.list[widget.index]['employeeNumber']}");
    controllerFirstName = new TextEditingController(
        text: "${widget.list[widget.index]['firstName']}");
    controllerLastName = new TextEditingController(
        text: "${widget.list[widget.index]['lastName']}");
    controllerCompany = new TextEditingController(
        text: "${widget.list[widget.index]['company']['name']}");
    controllerPosition = new TextEditingController(
        text: "${widget.list[widget.index]['position']['name']}");
    controllerRole = new TextEditingController(
        text: "${widget.list[widget.index]['roles'][0]}");
    controllerAnnLeaveDays = new TextEditingController(
        text: "${widget.list[widget.index]['annualLeaveDays']}");
    controllerSickLeaveDays = new TextEditingController(
        text: "${widget.list[widget.index]['sickLeaveDays']}");
    controllerFamilyResponsibility = new TextEditingController(
        text: "${widget.list[widget.index]['familyResponsibility']}");
    controllerContactNumber = new TextEditingController(
        text: "${widget.list[widget.index]['contactNumber']}");
    controllerEmail = new TextEditingController(
        text: "${widget.list[widget.index]['email']}");
    controllerPassword = new TextEditingController(
        text: "${widget.list[widget.index]['password']}");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Edit Employee Data"),
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
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                new RaisedButton(
                  child: new Text("Edit Employee"),
                  color: Colors.blue,
                  onPressed: () {
                    editEmployee();
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => EmployeesHome()));
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
