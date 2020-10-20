import 'dart:convert';
import 'package:App_idolconsulting/PaySlips/Employees.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';

import 'Admin.dart';

class AdminApply extends StatefulWidget {
  @override
  _AdminApplyState createState() => _AdminApplyState();
}

class _AdminApplyState extends State<AdminApply> {

  String _filePath;

  String _mySelection;
  final String url = "https://app.idolconsulting.co.za/idols/users/all";
  List data = List(); //edited line

  Future<String> getSWData() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      data = resBody;
    });

    print(resBody);

    return "Sucess";
  }

  final _formKey = GlobalKey<FormState>();


  TextEditingController _startKmController = TextEditingController();
  TextEditingController _endKmController = TextEditingController();
  TextEditingController _travelDateController;
  TextEditingController _commentController = TextEditingController();
  TextEditingController _ratePerKm = TextEditingController();


  final DateFormat dateFormat=DateFormat('dd MMMM yyyy');
  DateTime _date = DateTime.now();

  Future<Null> _selectdateTime(BuildContext context) async {
    DateTime datepicker = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(1600),
        lastDate: DateTime(3000));

    if (datepicker != null && datepicker != _date) {
      setState(() {
        _date = datepicker;
        _travelDateController.text= dateFormat.format(_date);

      });
    }
  }

  void save() async {
    SharedPreferences prefs =await SharedPreferences.getInstance();
    String stringValue = prefs.getString('token');
    Map<String, String> headers = {"content-type": "application/json",
      "Accept": "application/json",
      "X_TOKEN":"$stringValue",
    };
    final body = jsonEncode({
      'user''id': _mySelection,
      'startKm': _startKmController.text,
      'endKm': _endKmController.text,
      'ratePerKm': _ratePerKm.text,
      'travelDate': _travelDateController.text,
      'comment': _commentController.text,
      'attachment' : _filePath,
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
            builder: (context) => new Admin()));
  }

  void getFilePath() async {
    String filePath = await FilePicker.getFilePath(type: FileType.any);
    if (filePath == '') {
      return;
    }
    setState(() {
      this._filePath = filePath;
    });
  }

  void saveAndApply() async {
    SharedPreferences prefs =await SharedPreferences.getInstance();
    String stringValue = prefs.getString('token');
    Map<String, String> headers = {"content-type": "application/json",
      "Accept": "application/json",
      "X_TOKEN":"$stringValue",
    };
    final body = jsonEncode({
      'user' 'id': _mySelection,
      'startKm': _startKmController.text,
      'endKm': _endKmController.text,
      'ratePerKm': _ratePerKm.text,
      'travelDate': _travelDateController.text,
      'comment': _commentController.text,
      'attachment' 'name': _filePath,
    });
    final response = await http.put(
        'https://app.idolconsulting.co.za/idols/travel-allowance',
        headers: headers,
        body: body
    );
    setState(() {
      if(response.statusCode == 200) {
        //print(response.body);
        print(jsonDecode(body));
      }
    });
    Navigator.pop(context);
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new Admin()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _travelDateController = TextEditingController();
    this.getSWData();
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
              child: SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: Column(
                        children: [
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
                          Card(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                                      height: 50,
                                      child: Container(
                                        padding: EdgeInsets.only(left: 16.0, right: 16.0),
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black54, width: 0.5)),
                                        margin: EdgeInsets.fromLTRB(3, 5, 10, 5),
                                        alignment: Alignment.topLeft,
                                        child:  new DropdownButton(
                                          hint: Container(
                                            child: Text('Employee*'),
                                          ),
                                          items: data.map((item) {
                                            return new DropdownMenuItem(
                                              child: new Text(item['firstName'] + ' ' + item['lastName']),
                                              value: item['id'].toString(),
                                            );
                                          }).toList(),
                                          onChanged: (newVal) {
                                            setState(() {
                                              _mySelection = newVal;
                                              print(_mySelection);
                                            });
                                          },
                                          value: _mySelection,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      height: 80,
                                      child: TextFormField(
                                        controller: _startKmController,
                                        decoration: InputDecoration(
                                            labelText: 'Start Km*',
                                            border: new OutlineInputBorder(
                                                borderRadius: new BorderRadius.circular(4.2),
                                                borderSide: new BorderSide()
                                            )
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter start Km';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    // SizedBox(height: 10,),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      height: 80,
                                      child: TextFormField(
                                        controller: _endKmController,
                                        decoration: InputDecoration(
                                            labelText: 'End Km*',
                                            border: new OutlineInputBorder(
                                                borderRadius: new BorderRadius.circular(4.2),
                                                borderSide: new BorderSide()
                                            )
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter end Km';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    // SizedBox(height: 10,),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      height: 80,
                                      child: TextFormField(
                                        controller: _ratePerKm,
                                        decoration: InputDecoration(
                                            labelText: 'Rate Per Km*',
                                            border: new OutlineInputBorder(
                                                borderRadius: new BorderRadius.circular(4.2),
                                                borderSide: new BorderSide()
                                            )
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter Rate Per Km';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    // SizedBox(height: 10,),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      height: 80,
                                      child: TextFormField(
                                        readOnly: true,
                                        controller: _travelDateController,
                                        decoration: InputDecoration(
                                            labelText: 'Travel Date*',
                                            border: new OutlineInputBorder(
                                                borderRadius: new BorderRadius.circular(4.2),
                                                borderSide: new BorderSide()
                                            )
                                        ),
                                        onTap: (){
                                          setState(() {
                                            _selectdateTime(context);
                                          });
                                        },
                                        keyboardType: TextInputType.multiline,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter date';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    // SizedBox(height: 10,),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      height: 80,
                                      child: TextFormField(
                                        controller: _commentController,
                                        decoration: InputDecoration(
                                            labelText: 'Comment',
                                            border: new OutlineInputBorder(
                                                borderRadius: new BorderRadius.circular(4.2),
                                                borderSide: new BorderSide()
                                            )
                                        ),
                                        // validator: (value) {
                                        //   if (value.isEmpty) {
                                        //     return 'Required field';
                                        //   }
                                        //   return null;
                                        // },
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.fromLTRB(100, 19, 80, 12),
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.black54)),
                                            child: _filePath == null
                                                ? new Text('Attach File')
                                                : new Text( _filePath),

                                          ),
                                          Container(
                                            padding: EdgeInsets.fromLTRB(0, 0, 0, 2),
                                            child: RaisedButton(
                                              padding: EdgeInsets.symmetric(vertical: 14.0),
                                              onPressed: () {getFilePath();},
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
                                    SizedBox(height: 40,),
                                    Container(
                                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        child: Container(
                                          child: RaisedButton(
                                            color: Colors.lightBlue,
                                            onPressed: () {
                                              // Validate returns true if the form is valid, or false
                                              // otherwise.
                                              if (_formKey.currentState.validate()) {
                                                // If the form is valid, display a Snackbar.
                                                saveAndApply();
                                              }
                                            },
                                            child: Text('Apply',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18,),
                                            ),
                                          ),
                                        )
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
                              )
                          )
                        ],
                      )
                  )
              )
            )
        )
    );
  }
}
