import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:App_idolconsulting/TravelAllowance/User.dart';
import 'package:file_picker/file_picker.dart';

import 'TravellingAllowance.dart';

class Apply extends StatefulWidget {
  @override
  _ApplyState createState() => _ApplyState();
}

class _ApplyState extends State<Apply> {

  DateTime _selectedDate;
  TextEditingController _textEditingController = TextEditingController();

  TextEditingController _startKmController = TextEditingController();
  TextEditingController _endKmController = TextEditingController();
  TextEditingController _travelDateController = TextEditingController();
  TextEditingController _commentController = TextEditingController();
  TextEditingController _ratePerKm = TextEditingController();

  List<User> employeeList = new List<User>();
  String emplyeeName;
  var items;

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

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[10],
      appBar: AppBar(
        title: Text(
          'Travel Allowance',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueGrey[400],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        child: SingleChildScrollView(
          child: Card(
            elevation: 40,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                Container(
                  padding: EdgeInsets.fromLTRB(260, 8, 5, 0),
                  child: Text(
                    '*Required fields',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: Text(
                    'Start Kilometers*',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                  height: 34,
                  child: TextField(
                    controller: _startKmController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: Text(
                    'End Kilometers*',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                  height: 34,
                  child: TextField(
                    controller: _endKmController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: Text(
                    'Rate Per Kilometer*',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                  height: 34,
                  child: TextField(
                    controller: _ratePerKm,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: Text(
                    'Travel Date*',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                  height: 34,
                  child: TextField(
                    readOnly: true,
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      //hintText: 'Please select date',
                      border: OutlineInputBorder(),
                    ),
                    onTap: () {
                      _selectDate(context);
                    },
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: Text(
                    'Comment*',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                  height: 60,
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    controller: _commentController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(150, 19, 80, 12),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54)),
                        child: _filePath == null
                            ? new Text('Attach File')
                            : new Text('Path' + _filePath),

                        //padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 2),
                        child: RaisedButton(
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
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: RaisedButton(
                    color: Colors.lightBlue,
                    onPressed: () async {
                      SharedPreferences prefs =await SharedPreferences.getInstance();
                      String stringValue = prefs.getString('token');
                      Map<String, String> headers = {"content-type": "application/json",
                        "Accept": "application/json",
                        "X_TOKEN":"$stringValue",
                      };
                      final body = jsonEncode({
                        'startKm': _startKmController.text,
                        'endKm': _endKmController.text,
                        // 'ratePerKm': _ratePerKm,
                        'travelDate': _travelDateController.text,
                        'comment': _commentController.text,
                        // 'attachment' 'name': //PickedFile,
                      });
                      final response = await http.put(
                          'https://app.idolconsulting.co.za/idols/travel-allowance',
                          headers: headers,
                          body: body
                      );
                      setState(() {
                        if(response.statusCode == 200) {
                           print(response.body);
                          print(jsonDecode(body));
                          //print(stringValue);
                        }
                      });
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new TravelAllowance()));
                    },
                    child: Text(
                      'Apply',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(
                    '*Complete all required fields',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      )
    );
  }

  _selectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _textEditingController
        ..text = DateFormat.yMMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textEditingController.text.length,
            affinity: TextAffinity.upstream));
    }
  }
}