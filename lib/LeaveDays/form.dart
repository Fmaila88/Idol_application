import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:App_idolconsulting/homescrean.dart';

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
      });
    }
  }


  @override
  void initState(){
    startDate=TextEditingController();
    endDate=TextEditingController();
  }
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: Text(
        'Leave',
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
                Text(
                  '*Required Fields',
                  style: TextStyle(
                    //color: '#013281'.toColor(),
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 10),
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
//                            padding: EdgeInsets.symmetric(
//                                horizontal: 90.0, vertical: 0),
//                      decoration: BoxDecoration(
//                          color: Colors.white,
//                          borderRadius: BorderRadius.circular(0),
//                          boxShadow: [
//                            BoxShadow(
//                              color: Color.fromRGBO(143, 148, 251, 3),
//                              //blurRadius: 3.0,
//                              offset: Offset(0, 10),
//                            )
//                          ]),
                  //copy here
                  child:Row(
                    children: <Widget>[
                      // Padding(padding: EdgeInsets.fromLTRB(50, 0, 200, 0)),
                      Padding(padding: EdgeInsets.symmetric(
                          horizontal: 0.0, vertical:0)),
                      Expanded(
                        child: Container(
                          child: FlatButton(
                            onPressed: () {},
                            color: Colors.blueGrey,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(20.0)),
                            child: Text('Annual'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FlatButton(
                          onPressed: () {},
                          color: Colors.blueGrey,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(20.0)),
                          child: Text('Sick'),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: FlatButton(
                            onPressed: () {},
                            color: Colors.blueGrey,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(20.0)),
                            child: Text('Family '),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: FlatButton(
                            onPressed: () {},
                            color: Colors.blueGrey,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(20.0)),
                            child: Text('Study Leave'),
                          ),
                        ),
                      ),
                    ],
                  ),

                ),


                Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 200, 0),
                  child:  Text("Start Date*"),
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
                  padding: EdgeInsets.fromLTRB(0, 100,0 , 0),
                  child:RaisedButton(

                      color: Colors.lightBlue[400],
                      child: Text("Apply"),
                      onPressed: (){
                        setState(() {

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
                                color: Colors.grey,
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
