import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
//import 'package:perfomance_appraisals/main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:convert';
import 'employeesclass.dart';
import 'performanceclass.dart';
//import 'data.dart';


//import 'package:flutter/cupertino.dart';
//import 'package:flutter/src/material/dropdown.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Performance Appraisals Details',
    home: perfomanceDetails(),
  ));
}

class perfomanceDetails extends StatefulWidget {

  @override
  State createState() => perfomanceDetailsState();

//static map(DropdownMenuItem<String> Function(String dropDownStringItem) param0) {}
}

//String title = 'DropDownButton';

class perfomanceDetailsState extends State<perfomanceDetails> {
  List<Perform> _employeeName = new List<Perform>();
  String names;

//   List _employeeName;

  Future<Perform> fetchEmployees() async {
    final response = await http.get(
        'https://app.idolconsulting.co.za/idols/performanceappraisals/all',
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      setState(() {
        var data = json.decode((response.body));
        for (int x = 0; x < data.length; x++) {
          var employees = new Perform(
              data[x]['id'].toString(),
              data[x]['date'].toString(),
              data[x]['employee'].toString(),
              data[x]['status'].toString());

          _employeeName.add(employees);
        }
      });
    }
  }

//  getFilePath() async {
//    try {
//      String filePath = await FilePicker.getFilePath(type: FileType.any);
//      if (filePath == '') {
//        return;
//
//      }
//      print("File path: " + filePath);
//      setState(() {
//        this._filePath = filePath;
//      });
//    } on PlatformException catch (e) {
//      print("Error while picking the file: " + e.toString());
//    }

  @override
  void initState() {
    fetchEmployees();
    super.initState();
  }

  String _filePath;

  getFilePath() async {
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
  var _branches = ['   Employee Names*           ','Andile Zulu', 'Basil Maringa', 'Bongani Mdletshe', 'Bongani Gumede', 'Caesar Mashau', 'David Ramoraswi', 'Emmanuel Xaba', 'Fiona Maila', 'Freddy Mokoele', 'Karabo Komane'];
  var currentItemSelected = '   Employee Names*           ';
  var _status = ['   Status*           ','Resolved', 'Pending', 'Reported' ];
  var currentStatus = '   Status*           ';
  var _type = ['      Type*        ','Compliment', 'Complain' ];
  var currenttype = '      Type*        ';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text(
          'Perfomance Appraisals',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueGrey[400],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                            'Employee name*',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                        ),
                        Container(
                          // padding: const EdgeInsets.only(left: 16.0, right: 16.0)
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius:BorderRadius.circular(5.0)
                          ),
                          // borderRadius: BorderRadius.circular(15.0),
                          margin: const EdgeInsets.all(11.0),
                          alignment: Alignment.topCenter,
                          child:  DropdownButton<String>(
                            items: _branches.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem),
                              );
                            }).toList(),
                            //hint: new Text("    -- Select Branch ---                        "),
                            onChanged: (String newValueSelected) {
                              setState(() {
                                this.currentItemSelected = newValueSelected;
                              });
                            },
                            value: currentItemSelected,
                          ),

                        ),
                        Container(
                          margin: const EdgeInsets.all(11.0),
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            'Status *',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                        ),
                        Container(
                          // padding: const EdgeInsets.only(left: 16.0, right: 16.0)
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius:BorderRadius.circular(5.0)
                          ),
                          // borderRadius: BorderRadius.circular(15.0),
                          margin: const EdgeInsets.all(11.0),
                          alignment: Alignment.topCenter,
                          child:  DropdownButton<String>(
                            items: _status.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem),
                              );
                            }).toList(),
                            //hint: new Text("    -- Select Branch ---                        "),
                            onChanged: (String newValueSelected) {
                              setState(() {
                                this.currentStatus = newValueSelected;
                              });
                            },
                            value: currentStatus,
                          ),

                        ),
                        Container(
                          margin: const EdgeInsets.all(11.0),
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            'Type *',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                        ),
                        Container(
                          // padding: const EdgeInsets.only(left: 16.0, right: 16.0)
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius:BorderRadius.circular(5.0)
                          ),
                          // borderRadius: BorderRadius.circular(15.0),
                          margin: const EdgeInsets.all(11.0),
                          alignment: Alignment.topCenter,
                          child:  DropdownButton<String>(
                            items: _type.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem),
                              );
                            }).toList(),
                            //hint: new Text("    --  ---                        "),
                            onChanged: (String newValueSelected) {
                              setState(() {
                                this.currenttype = newValueSelected;
                              });
                            },
                            value: currenttype,
                          ),

                        ),

                        Container(
                          margin: const EdgeInsets.all(11.0),
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            'Comments *',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                        ),
                        Container(
                          padding:EdgeInsets.fromLTRB(10, 10, 10, 20),
                          child:  TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder()),
                          ),
                        ),

                        Row(
                          children: <Widget> [
                            Container(
                              padding: EdgeInsets.fromLTRB(60, 19, 60, 12),
                              margin: EdgeInsets.fromLTRB(11, 0, 1, 5),
                              //readonly:false,
                              alignment: Alignment.center,

                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black54),
                                  borderRadius:BorderRadius.circular(5.0)
                              ),
                              child: _filePath == null
                                  ? new Text('Attach')
                                  : new Text('Path' + _filePath),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                                        decoration: BoxDecoration(
//                                            border: Border.all(color: Colors.black54),
//                                            borderRadius:BorderRadius.circular(15.0)
//                                        ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 1, 0, 10),
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    //side: BorderSide(color: Colors.red)
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 14.0),

                                  onPressed: getFilePath,
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
                            ),
                          ],
                        ),

                        Container(
                          margin: const EdgeInsets.all(11.0),
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: RaisedButton(
                            elevation: 15,
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
                                fontSize: 18,
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
                      ]),
                ),
              ),


            ],
          ),
        ),
//                ),
      ),
    );
  }
}
