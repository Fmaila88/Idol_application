import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
//import 'package:App_idolconsulting/HomePage/homescrean.dart';
import 'package:App_idolconsulting/PaySlips/Employees.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'EmployeeList.dart';



class Formpage extends StatefulWidget {
  @override
  _FormpageState createState() => _FormpageState();
}

class _FormpageState extends State<Formpage> {
  String email;
  DateTime _date = DateTime.now();
  DateTime _dateend = DateTime.now();
  final DateFormat dateFormat=DateFormat('dd MMMM yyyy');

  TextEditingController startDate;
  TextEditingController endDate;
  String _filePath;
  List<Employees> employeeList=new List<Employees>();
  List empList;
  var items;
  List<Employees> _employeeName = new List<Employees>();

  String startD,endD;
  String leaveType;

  Future<String> fetchEmployees() async {


    final response = await http.get(
      // 'https://app.idolconsulting.co.za/idols/leaves/1/10/ASC/id?keyword=',
        'http://app.idolconsulting.co.za/idols/users/all',
        headers: {"Accept": "application/json",

        });

    if (response.statusCode == 200) {
      setState(() {

        //var data = json.decode((response.body));
         empList = json.decode((response.body));

         for (int x = 0; x < empList.length; x++) {
           var employees = new Employees(
               empList[x]['firstName'].toString(), empList[x]['lastName'].toString());

           _employeeName.add(employees);
         }


      });
    }
  }

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


  Future<Null> _selectdateTime(BuildContext context) async {
    DateTime datepicker = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(1600),
        lastDate: DateTime(3000));

    if (datepicker != null && datepicker != _date) {
      setState(() {
        _date = datepicker;
        startDate.text= dateFormat.format(_date);
        startD=startDate.text;
      });
    }
  }

  Future<Null> _selectEnddateTime(BuildContext context) async {
    DateTime datepicker = await showDatePicker(
        context: context,
        initialDate: _dateend,
        firstDate: DateTime(1600),
        lastDate: DateTime(3000));

    if (datepicker != null && datepicker != _dateend) {
      setState(() {
        _dateend = datepicker;
        endDate.text= dateFormat.format(_dateend);
               // print(_date.toString());
        endD=endDate.text;

      });
    }
  }

  Future<String> applyLeave() async {
    SharedPreferences prefs= await SharedPreferences.getInstance();

    String token=prefs.getString('userToken');

    final response = await http.put(

      'https://app.idolconsulting.co.za/idols/leaves',
      headers: {"Accept": "application/json",
            "content-type": "application/json","X_TOKEN": token},

        body:jsonEncode({
          'end': endD,
          'start': startD,
          'comment': comment.text,
          'type':leaveType,
          'attachment':_filePath,
        })
    );


    if (response.statusCode == 200) {
      setState(() {

       // print('Data sentzzzzzzzzzzzzzzzzzzzzzzzzzzzz');

        print(response.body);
      });
    }else{

      print(response.body);

    }
  }

TextEditingController comment;
  int selectedRadioTile;
  int selectedRadio;
  @override
  void initState(){
    startDate=TextEditingController();
    endDate=TextEditingController();
    comment=TextEditingController() ;
    this.fetchEmployees();
    //this.applyLeave();
    super.initState();
  }
  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }


  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
        'Leave Details',
        style:TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.white,
        ),
      ),
      backgroundColor: Colors.blueGrey[400],
    ),


      body: Container(
        alignment: Alignment.topRight,
        margin: EdgeInsets.fromLTRB(0, 0, 50, 20),
        child: SingleChildScrollView(
          child: Column(
              children: <Widget>[


                Row(

          children: <Widget>[

              Expanded(

              child:Container(
               // margin: EdgeInsets.only(left:250),
                  alignment:Alignment.topRight,
                child: Text(
                  '*Required Fields',
                  style: TextStyle(
                    //color: '#013281'.toColor(),
                    color: Colors.black,
                    fontWeight:FontWeight.bold,
                    fontSize: 10,
                  ),
                ),

              ),

            )

            ]
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RadioListTile(
                        value: 4,
                        groupValue: selectedRadioTile,
                        title: Text("Annual"),
                        onChanged: (val) {
                          setSelectedRadioTile(val);
                          leaveType= "Annual";

                        },
                        activeColor: Colors.red,
                        selected: false,

                      ),
                    ),

                    Expanded(
                      child: RadioListTile(
                        value: 3,
                        groupValue: selectedRadioTile,
                        title: Text("family"),
                        onChanged: (val) {

                          setSelectedRadioTile(val);
                          leaveType= "family";
                        },
                        activeColor: Colors.red,
                        selected: false,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RadioListTile(
                        value: 2,
                        groupValue: selectedRadioTile,
                        title: Text("Sick"),
                        onChanged: (val) {

                          setSelectedRadioTile(val);
                          leaveType= "Sick";
                        },
                        activeColor: Colors.red,
                        selected: false,
                      ),
                    ),

                    Expanded(
                      child: RadioListTile(
                        value: 1,
                        groupValue: selectedRadioTile,

                        title: Text("Study Leave"),
                        onChanged: (val) {

                          setSelectedRadioTile(val);
                          leaveType= "Study Leave";

                        },
                        activeColor: Colors.red,
                        selected: false,
                      ),
                    ),
                  ],
                ),






                Container(

                  child:  Column(

                    children: <Widget>[

//                      Container(
//                        // padding: const EdgeInsets.only(left: 16.0, right: 16.0)
//                        padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
//                        decoration: BoxDecoration(
//                            border: Border.all(color: Colors.black54)),
//                        margin: const EdgeInsets.all(11.0),
//                        alignment: Alignment.topCenter,
//
//                        child: DropdownButton<Employees>(
//                          hint: Text('Employee Names'),
//                          elevation: 5,
//                          icon: Icon(Icons.arrow_drop_down),
//                          iconSize: 40.0,
//                          items: _employeeName.map((Employees names) {
//                            return DropdownMenuItem<Employees>(
//                              value: names,
//                              child: Text("$names"),
//                            );
//                          }).toList(),
//                          onChanged: (value) {
//                            setState(() {
//                              this.items = value;
//                            });
//                          },
//                          value: items,
//                        ),
//                     ),

                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 200, 0),

                        child: Text("Start Date*"),

                      ),




                    ],

                  ),
                ),


                Container(
                  padding:EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child:  TextFormField(
                    readOnly: true,
                    controller: startDate,
                    onTap: (){
                      setState(() {
                        _selectdateTime(context);
                      });
                    },
                    validator: (value)  => value.isEmpty
                        ? 'User name is required' : null,//validateEmail(value.trim()),
                    onChanged: (value){
                      this.email = value;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder()),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 200, 0),
                  child:  Text("End Date*"),
                ),

                Container(
                  padding:EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child:  TextFormField(
                    readOnly: true,
                    controller:endDate,
                    onTap: (){
                      setState(() {
                        _selectEnddateTime(context);
                      });
                    },
                    validator: (value)  => value.isEmpty
                        ? 'User name is required' : null,//validateEmail(value.trim()),
                    onChanged: (value){
                      this.email = value;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder()),
                  ),
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 200, 10),
                  child:  Text("days 0"),
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 200, 0),
                  child:  Text("Comment*"),
                ),
                Container(
                  padding:EdgeInsets.fromLTRB(10, 10, 10, 5),

                  child:  TextFormField(
                    controller:comment ,
                    validator: (value)  => value.isEmpty
                        ? 'User name is required' : null,//validateEmail(value.trim()),
                    onChanged: (value){
                      this.email = value;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder()),
                  ),
                ),

                Row(
                  children: <Widget> [
                    Container(
                      padding: EdgeInsets.fromLTRB(125, 19, 80, 12),
                      margin: EdgeInsets.fromLTRB(11, 0, 0, 0),
                      //readonly:false,
                      alignment: Alignment.center,

                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54)),
                      child: _filePath == null
                          ? new Text('Attach')
                          : new Text('Path' + _filePath),
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

                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top:20),

                  child:RaisedButton(

                      color: Colors.lightBlue[400],
                      child: Text("Apply"),
                      onPressed: (){
                        saved(context);
                        setState(() {
                          applyLeave();
                        });
                      }
                  ),
                ),

                Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.fromLTRB(0, 0, 50, 20),
                    child: Column(
                        children: <Widget>[
                          Text(
                            '*Complete all required fields',
                            style: TextStyle(
                              //color: '#013281'.toColor(),
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 10),

                          ),
                        ]
                    )
                ),

              ]
          ),
        ),
      ),
    );
  }
  void saved(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text("Saved"),
      content: Text("Detailed saved Successfully"),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}

//RaisedButton(
//child: Text("save"),
//onPressed: () async {
//SharedPreferences prefs =
//    await SharedPreferences.getInstance();
//
//String stringValue = prefs.getString('token');
//var response;
//Map<String, String> headers = {
//  "Content-Type": "application/json",
//  "Accept": "application/json",
//  "X_TOKEN": "$stringValue",
//};
//final body = jsonEncode({
//  "comment": _eventController.text,
//  "end": "$endTimeDate",
//  "endTime": _startController.text,
//  "start": "$startTimeDate",
//  "startTime": _startController.text,
//});
//print(body);
//response = await http.put(
//'https://app.idolconsulting.co.za/idols/timesheetitems',
//headers: headers,
//body: body);
//setState(() {
////                                if (_eventController.text.isEmpty) {
////                                  return _eventController.text.isEmpty;
////                                }
//if (_events[_controller.selectedDay] != null ||
//_eventController.text.isNotEmpty) {
//_events[_controller.selectedDay] = [
//"comment:${_eventController.text}",
//"StartTime:${_startController.text}",
//"EndTime:${_endtController.text}"
//];
//_eventController.clear();
//Navigator.pop(context);
//}
//prefs.setString(
//"events", json.encode(encodeMap(_events)));
////                                else {
////                                  _events[_controller.selectedDay] = [
////                                    _eventController.text
////                                  ];
////                                  prefs.setString("events",
////                                      json.encode(encodeMap(_events)));
////                                  _eventController.clear();
////                                  Navigator.pop(context);
////                                }
//
//if (response.statusCode == 200) {
////print("Token: $stringValue");
//print(response.body);
//return Timesheet.fromJson(
//json.decode(response.body));
//} else {
//print(response.body);
//print("Token: $stringValue");
//
//print(response.body);
//throw Exception('Failed to load timesheet');
//}
//});
//},
//color: Colors.blue,
//)
