import 'dart:convert';
import 'package:App_idolconsulting/TravelAllowance/Model/Allowance_Model.dart';
import 'package:App_idolconsulting/TravelAllowance/Model/User.dart';
import 'package:App_idolconsulting/TravelAllowance/Service/Allowance_Service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';

import 'Travel_Allowance.dart';


class Admin_Save extends StatefulWidget {
  @override
  _Admin_SaveState createState() => _Admin_SaveState();
}

class _Admin_SaveState extends State<Admin_Save> {

  String _filePath;

  String _mySelection;
  List data = List(); //edited line

  //Get users for the dropdown button
  Future<String> getSWData() async {

    final String url = "https://app.idolconsulting.co.za/idols/users/all";
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      data = resBody;
    });
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

  void getFilePath() async {
    String filePath = await FilePicker.getFilePath(type: FileType.any);
    if (filePath == '') {
      return;
    }
    setState(() {
      this._filePath = filePath;
    });
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
                                                value: item['id'],
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
                                              onPressed: () async {
                                                
                                                // final allowance = Allowance_Model(
                                                //   startKm: double.parse(_startKmController.text),
                                                //   endKm: double.parse(_endKmController.text),
                                                // );
                                                //
                                                // Services.createAllowance(allowance);
                                                
                                                var url = "https://app.idolconsulting.co.za/idols/travel-allowance";
                                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                                String token = prefs.getString('userToken');
                                                Map<String, String> headers = {
                                                  "content-type": "application/json",
                                                  "Accept": "application/json",
                                                  "X_TOKEN": "$token",
                                                };

                                                final body = jsonEncode({
                                                  'user': {'id': _mySelection},
                                                  'startKm': _startKmController.text,
                                                  'endKm': _endKmController.text,
                                                  'ratePerKm': _ratePerKm.text,
                                                  'travelDate': _travelDateController.text,
                                                  'comment': _commentController.text,
                                                });

                                                final response = await http.put(url, headers: headers, body: body);

                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => Admin_Allowance()));

                                                print(body);
                                                if (response.statusCode == 200) {
                                                  print(json.decode(response.body));
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
