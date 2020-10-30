import 'dart:convert';
import 'package:App_idolconsulting/TravelAllowance/Model/Allowance_Model.dart';
import 'package:App_idolconsulting/TravelAllowance/Service/Allowance_Service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Travel_Allowance.dart';


class Admin_modify extends StatefulWidget {
  int index;
  List list;
  Admin_modify(this.list, this.index);
  @override
  _Admin_modifyState createState() => _Admin_modifyState();
}

class _Admin_modifyState extends State<Admin_modify> {

  TextEditingController _startKmController = new TextEditingController();
  TextEditingController _endKmController = new TextEditingController();
  TextEditingController _travelDateController = new TextEditingController();
  TextEditingController _commentController = new TextEditingController();
  TextEditingController _ratePerKmController = new TextEditingController();
  TextEditingController _employeeController = new TextEditingController();

  String _filePath;
  String _status;

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
    // _status = widget.list.elementAt(widget.index).status;
    print(widget.list.elementAt(widget.index).status);
    _employeeController = new TextEditingController(
        text: widget.list.elementAt(widget.index).firstName + ' ' +
              widget.list.elementAt(widget.index).lastName);
    _startKmController = new TextEditingController(
        text: widget.list.elementAt(widget.index).startKm.toString());
    _endKmController = new TextEditingController(
        text: widget.list.elementAt(widget.index).endKm.toString());
    _ratePerKmController = new TextEditingController(
        text: widget.list.elementAt(widget.index).ratePerKm.toString());
    _travelDateController = new TextEditingController(
        text: widget.list.elementAt(widget.index).travelDate.toString());
    _commentController = new TextEditingController(
    text: widget.list.elementAt(widget.index).comment.toString());
    // print('Id = '+ widget.list.elementAt(widget.index).id);
    // print('User id = ' + widget.list.elementAt(widget.index).userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightGreen[10],
        appBar: AppBar(
          title: Text(
            'Edit Travel Allowance',
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
                        'Employee*',
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
                        controller: _employeeController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
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
                        controller: _ratePerKmController,
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
                        controller: _travelDateController,
                        decoration: InputDecoration(
                          //hintText: 'Please select date',
                          border: OutlineInputBorder(),
                        ),
                        onTap: () {
                          _selectdateTime(context);
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
                    SizedBox(height: 20),
                    Row(
                      children: <Widget> [
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: RaisedButton(
                            color: Colors.lightBlue,
                            onPressed: () async {
                              var url = "https://app.idolconsulting.co.za/idols/travel-allowance";
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              String token = prefs.getString('userToken');
                              Map<String, String> headers = {
                              "content-type": "application/json",
                              "Accept": "application/json",
                              "X_TOKEN": "$token",
                              };

                              final body = jsonEncode({
                                'id': widget.list.elementAt(widget.index).id,
                                'user': {'firstName': widget.list.elementAt(widget.index).firstName,
                                          'id': widget.list.elementAt(widget.index).userId,
                                          'lastName':widget.list.elementAt(widget.index).lastName },
                                'startKm': _startKmController.text,
                                // 'status' : _status,
                                'endKm': _endKmController.text,
                                'ratePerKm': _ratePerKmController.text,
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
                            child: Text(
                              'Update',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                       ],
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
}
