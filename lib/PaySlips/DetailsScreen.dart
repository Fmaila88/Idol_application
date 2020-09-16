import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'Employees.dart';

class DetailsScreen extends StatefulWidget {
  @override
  _DetailsScreenState createState() => new _DetailsScreenState();
}

String title = 'DropDownButton';

class _DetailsScreenState extends State<DetailsScreen> {
  List<Employees> _employeeName = new List<Employees>();
  String names;
  // List _employeeName;

  Future<Employees> fetchEmployees() async {
    final response = await http.get(
        'http://app.idolconsulting.co.za/idols/users/all',
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      setState(() {
        var data = json.decode((response.body));
        for (int x = 0; x < data.length; x++) {
          var employees = new Employees(
              data[x]['firstName'].toString(), data[x]['lastName'].toString());

          _employeeName.add(employees);
        }
      });
    }
  }

  @override
  void initState() {
    fetchEmployees();
    super.initState();
  }

  String _filePath;

  void getFilePath() async {
    try {
      String filePath = await FilePicker.getFilePath(type: FileType.any);
      if (filePath == '') {
        return;
      }
      print("File path: " + filePath);
      setState(() {
        this._filePath = filePath;
      });
    } on PlatformException catch (e) {
      print("Error while picking the file: " + e.toString());
    }
  }

  var items;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Payslip Details'),
          backgroundColor: Colors.blueGrey[300],
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(11.0),
                        alignment: Alignment.topRight,
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          '* Required fields',
                          style: TextStyle(
                              color: Colors.black26,
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(11.0),
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          'Employee *',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                      ),
                      Container(
                        // padding: const EdgeInsets.only(left: 16.0, right: 16.0)
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54)),
                        margin: const EdgeInsets.all(11.0),
                        alignment: Alignment.topCenter,

                        child: DropdownButton<Employees>(
                          hint: Text('Employee Name'),
                          elevation: 5,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 40.0,
                          items: _employeeName.map((Employees names) {
                            return DropdownMenuItem<Employees>(
                              value: names,
                              child: Text("$names"),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              this.items = value;
                            });
                          },
                          value: items,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(100, 19, 80, 12),
                            margin: const EdgeInsets.fromLTRB(11, 0, 0, 0),
                            // margin: const EdgeInsets.all(11.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54)),
                            // padding: const EdgeInsets.only(
                            //left: 16.0, bottom: 15.0, top: 15.0, right: 16.0),
                            child: _filePath == null
                                ? new Text('Attach PaySlip')
                                : new Text('Path' + _filePath),

                            //padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          ),
                          // margin: const EdgeInsets.all(11.0),
                          // margin: const EdgeInsets.all(11.0),
                          // alignment: Alignment.topLeft,
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 2),
                            // decoration: BoxDecoration(
                            //  border: Border.all(color: Colors.black54)),

                            child: RaisedButton(
                              padding: EdgeInsets.symmetric(vertical: 14.0),
                              onPressed: getFilePath,
                              // label: 'Select file',
                              child: Text(
                                'Browse',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.all(11.0),
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: RaisedButton(
                          color: Colors.lightBlue,
                          onPressed: () {
                            Navigator.of(context).pop();
                            setState(() {});
                          },
                          child: Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(11.0),
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          '* Complete all required fields',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
