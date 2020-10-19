import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';

import '../Admin/Admin.dart';
import 'TravellingAllowance.dart';

class Edit_Allowance extends StatefulWidget {
  Map<String, dynamic> list;
  int index;
  Edit_Allowance(this.list, this.index);
  @override
  _Edit_AllowanceState createState() => _Edit_AllowanceState();
}

class _Edit_AllowanceState extends State<Edit_Allowance> {
  String _filePath;
  Map<String, dynamic> users;
  TextEditingController _startKmController;
  TextEditingController _endKmController;
  TextEditingController _travelDateController;
  TextEditingController _commentController;
  TextEditingController _ratePerKm;
  TextEditingController _employeeController;

  final DateFormat dateFormat = DateFormat('dd MMMM yyyy');
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
        _travelDateController.text = dateFormat.format(_date);
      });
    }
  }

  void deleteData() async {
    var url = "https://app.idolconsulting.co.za/idols/travel-allowance";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('userToken');
    Map<String, String> headers = {
      "content-type": "application/json",
      "Accept": "application/json",
      "X_TOKEN": "$stringValue",
    };
    String id = "${widget.list['content'][widget.index]['id']}";
    http.delete(
      url + "/" + id,
      headers: headers,
    );
  }

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      title: new Text('Wanring'),
      content: new Text("Are your sure you want to Delete this  item?"),
      actions: [
        new RaisedButton(
          child: new Text(
            "YES",
            style: new TextStyle(color: Colors.black),
          ),
          color: Colors.redAccent,
          onPressed: () {
            print('${widget.list['content'][widget.index]['id']}');
            deleteData();
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => TravelAllowance()));
          },
        ),
        new RaisedButton(
            child: new Text("NO", style: new TextStyle(color: Colors.black)),
            color: Colors.redAccent,
            onPressed: () => Navigator.pop(context)),
      ],
    );
    showDialog(context: context, child: alertDialog);
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
    _employeeController = new TextEditingController(
        text:
            "${widget.list['content'][widget.index]['user']['firstName'] + ' ' + widget.list['content'][widget.index]['user']['lastName'].toString()}");
    _startKmController = new TextEditingController(
        text: "${widget.list['content'][widget.index]['startKm'].toString()}");
    _endKmController = new TextEditingController(
        text: "${widget.list['content'][widget.index]['endKm'].toString()}");
    _ratePerKm = new TextEditingController(
        text:
            "${widget.list['content'][widget.index]['ratePerKm'].toString()}");
    _travelDateController = new TextEditingController(
        text:
            "${widget.list['content'][widget.index]['travelDate'].toString()}");
    _commentController = new TextEditingController(
        text: "${widget.list['content'][widget.index]['comment'].toString()}");
    print('Id = ' + widget.list['content'][widget.index]['id']);
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
                  children: <Widget>[
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
                                : new Text(_filePath),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 2),
                            child: RaisedButton(
                              padding: EdgeInsets.symmetric(vertical: 14.0),
                              onPressed: () {
                                getFilePath();
                              },
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
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: RaisedButton(
                            color: Colors.lightBlue,
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              String stringValue = prefs.getString('token');
                              Map<String, String> headers = {
                                "content-type": "application/json",
                                "Accept": "application/json",
                                "X_TOKEN": "$stringValue",
                              };
                              final body = jsonEncode({
                                "id": widget.list['content'][widget.index]
                                    ['id'],
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
                                  body: body);
                              setState(() {
                                if (response.statusCode == 200) {
                                  //print(response.body);
                                  print(jsonDecode(body));
                                }
                              });
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                          new TravelAllowance()));
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

                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: RaisedButton(
                            color: Colors.redAccent,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => AllowanceDelete());
                            },
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),

                        // Container(
                        //   padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        //   child: RaisedButton(
                        //     color: Colors.redAccent,
                        //     onPressed: () {
                        //       confirm();
                        //     },
                        //     child: Text(
                        //       'Delete',
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //         fontWeight: FontWeight.w500,
                        //         fontSize: 18,
                        //       ),
                        //     ),
                        //   ),
                        // ),
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
            )));
  }
}

class AllowanceDelete extends StatelessWidget {
  _Edit_AllowanceState obj = new _Edit_AllowanceState();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Warning',
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.bold, fontSize: 25),
      ),
      content: Text(
        'Are you sure you want to delete this application?',
        style: TextStyle(fontSize: 16),
      ),
      actions: [
        FlatButton(
          child: Text('Yes'),
          onPressed: () {
            obj.deleteData();
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new TravelAllowance()));
          },
        ),
        FlatButton(
          child: Text('No'),
          onPressed: () {
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new TravelAllowance()));
          },
        )
      ],
    );
  }
}

// class AllowanceDelete extends StatelessWidget {
//   _Edit_AllowanceState obj = new _Edit_AllowanceState();
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Warning',
//         style: TextStyle(
//             color: Colors.red,
//             fontWeight: FontWeight.bold,
//             fontSize: 25
//         ),),
//       content: Text('Are you sure you want to delete this item?',
//         style: TextStyle(
//             fontSize: 16
//         ),),
//       actions: [
//         FlatButton(
//           child: Text('Yes'),
//           onPressed: () {
//             obj.deleteData();
//             Navigator.of(context).push(new MaterialPageRoute(
//                 builder: (BuildContext context) => new TravelAllowance()));
//           },
//         ),
//         FlatButton(
//           child: Text('No'),
//           onPressed: () {
//             Navigator.of(context).push(new MaterialPageRoute(
//                 builder: (BuildContext context) => new TravelAllowance()));
//           },
//         )
//       ],
//     );
//   }
// }
