import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'timesheetClass.dart';
import 'package:App_idolconsulting/HopePage/homescrean.dart';

//Future<Timesheet> TimesheetSendData(String comment, String end, String endTime,
//    String start, String startTime) async {
//  var url = 'https://app.idolconsulting.co.za/idols/timesheetitems';
//  final http.Response response = await http.put(
//    url,
//    headers: <String, String>{
//      'Content-Type': 'application/json; charset=UTF-8',
//      'Accept': 'application/json text/plain, */*',
//    },
//    body: jsonEncode(<String, String>{
//      "comment": comment,
//      "end": end,
//      "endTime": endTime,
//      "start": start,
//      "startTime": startTime,
//    }),
//  );
//  if (response.statusCode == 200) {
//    // If the server did return a 201 CREATED response,
//    // then parse the JSON.
//    print(response.body);
//    //return Timesheet.fromJson(json.decode(response.body));
//  } else {
//    print(response.body);
//    // If the server did not return a 201 CREATED response,
//    // then throw an exception.
//    print(response.body);
//    //throw Exception('Failed to load timesheet');
//  }
//}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'TimeSheet Details',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: homeScreen(),
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  TextEditingController _eventController;
  TextEditingController _startController;
  TextEditingController _endtController;
  List<dynamic> _selectedEvents;
  SharedPreferences prefs;
  Future<Timesheet> timeData;
  final DateFormat dateFormat = DateFormat('dd MMMM yyyy');

  TimeOfDay time = TimeOfDay.now();
  TimeOfDay endtime = TimeOfDay.now();
  String startTimeDate = " ";
  Future<Null> getTime(BuildContext context) async {
    TimeOfDay timePicker = await showTimePicker(
      context: context,
      initialTime: time,
    );
    if (timePicker != null && timePicker != time) {
      setState(() {
        time = timePicker;

        _startController.text = "${time.hour}:${time.minute}";
        startTimeDate =
            "${dateFormat.format(_controller.selectedDay)} ${time.hour}:${time.minute} ";
        print(startTimeDate);
      });
    }
  }

  String endTimeDate = " ";

  Future<Null> getEndTime(BuildContext context) async {
    TimeOfDay timePicker = await showTimePicker(
      context: context,
      initialTime: endtime,
    );
    if (timePicker != null && timePicker != endtime) {
      setState(() {
        endtime = timePicker;
        _endtController.text = "${endtime.hour}:${endtime.minute}";
        endTimeDate =
            "${dateFormat.format(_controller.selectedDay)} ${endtime.hour}:${endtime.minute} ";
        print(endTimeDate);
      });
    }
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {});
    _events = Map<DateTime, List<dynamic>>.from(
        decodeMap(json.decode(prefs.getString("events") ?? "{}")));
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = newMap[key];
    });
    return newMap;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerCodeOnly(),
      appBar: AppBar(
        title: Text("TimeSheet Details"),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              events: _events,
              calendarStyle: CalendarStyle(
                todayColor: Colors.blueGrey, //changing the color of today's day
                //selectedColor: Theme.of(context).primaryColor,changing the color of the moving selector
                todayStyle:
                    TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
              ),
              onDaySelected: (date, event) {
                setState(() {
                  _selectedEvents = event;
                  _showAddDialog();
                });
              },
              calendarController: _controller,
            ),
            ..._selectedEvents.map((event) => ListTile(
                  title: Text(event),
                )),
          ],
        ),
      ),
    );
  }

  _showAddDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.blueGrey[300],
              insetPadding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: Center(
                  child: new Text(
                "${dateFormat.format(_controller.selectedDay)}",
                style: TextStyle(color: Colors.white),
              )),
              content: SingleChildScrollView(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 50, 0),
                      //padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: new Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                            child: Text(
                              "StartTime *",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextField(
                      readOnly: true,
                      onTap: () {
                        setState(() {
                          getTime(context);
                        });
                      },
                      controller: _startController,
                      decoration: new InputDecoration(
                        hintText: "please select startTime",
                        prefixIcon: Icon(
                          Icons.query_builder,
                          color: Colors.blueGrey[800],
                        ),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueGrey[500])),
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 50, 0),
                      //padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: new Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: Text(
                              "EndTime *",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextField(
                      readOnly: true,
                      controller: _endtController,
                      decoration: new InputDecoration(
                        hintText: "please select EndTime",
                        prefixIcon: Icon(
                          Icons.query_builder,
                          color: Colors.blueGrey[800],
                        ),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueGrey[500])),
                      ),
                      onTap: () {
                        getEndTime(context);
                      },
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Text(
                        "Total Hours:",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 5),
                      child: Text(
                        "Comment *",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      controller: _eventController,
                      decoration: new InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueGrey)),
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      //padding: EdgeInsets.fromLTRB(0, 0, 143, 0),
                      child: Row(
                        children: <Widget>[
                          RaisedButton(
                            child: Text("Delete"),
                            onPressed: () {},
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          RaisedButton(
                            child: Text("close"),
                            onPressed: () {},
                          ),
                          SizedBox(
                            width: 7.0,
                          ),
                          RaisedButton(
                            child: Text("save"),
                            onPressed: () {
                              setState(() async {
                                if (_eventController.text.isEmpty) return;
                                if (_events[_controller.selectedDay] != null) {
                                  _events[_controller.selectedDay]
                                      .add(_eventController.text);
                                } else {
                                  _events[_controller.selectedDay] = [
                                    _eventController.text
                                  ];
                                  prefs.setString("events",
                                      json.encode(encodeMap(_events)));
                                  _eventController.clear();
                                  Navigator.pop(context);
                                }
//                                timeData = TimesheetSendData(
//                                    _eventController.text,
//                                    endTimeDate,
//                                    _startController.text,
//                                    startTimeDate,
//                                    _startController.text);
                                var response;
                                Map<String, String> headers = {
                                  "Content-Type": "application/json",
                                  "Accept": "application/json"
                                };
                                final body = jsonEncode({
                                  "comment": _eventController.text,
                                  "end": endTimeDate,
                                  "endTime": _startController.text,
                                  "start": startTimeDate,
                                  "startTime": _startController.text,
                                });
                                response = await http.put(
                                    'https://app.idolconsulting.co.za/idols/timesheetitems',
                                    headers: headers,
                                    body: body);
                                if (response.statusCode == 200) {
                                  // If the server did return a 201 CREATED response,
                                  // then parse the JSON.
                                  print(response.body);
                                  //return Timesheet.fromJson(json.decode(response.body));
                                } else {
                                  print(response.body);
                                  // If the server did not return a 201 CREATED response,
                                  // then throw an exception.
                                  print(response.body);
                                  //throw Exception('Failed to load timesheet');
                                }
                              });
                            },
                            color: Colors.blue,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  @override
  void initState() {
    super.initState();

    _events = {};
    _eventController = TextEditingController();
    _startController = TextEditingController();
    _endtController = TextEditingController();
    _controller = CalendarController();
    _selectedEvents = [];
    initPrefs();
  }
}

class homeScreen extends StatefulWidget {
  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  var table_info = TabelData();
  int rowPerPage = PaginatedDataTable.defaultRowsPerPage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerCodeOnly(),
      appBar: AppBar(
        title: Text("Time Sheets"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Text(
                  "Time Sheets",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: Text(
                  "Capture,view and approve time sheets",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: RaisedButton.icon(
                  onPressed: () {
                    _navigateToCreateTimeSheet(context);
                  },
                  icon: Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                  ),
                  label: Text(
                    "create month time sheet",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.blue,
                ),
              ),
              PaginatedDataTable(
                header: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 14, 0),
                  child: TextField(
                    //readOnly: true,
                    // controller: _endtController,
                    decoration: new InputDecoration(
                      hintText: "search",
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.blueGrey[800],
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey[500])),
                    ),
                    onTap: () {
                      //getEndTime(context);
                    },
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                columns: [
                  DataColumn(label: Text("Month")),
                  DataColumn(label: Text("Normal Hours")),
                  DataColumn(label: Text("OverTime Hours")),
                  // DataColumn(label: Text("Col#4")),
                ],
                source: table_info,
                onRowsPerPageChanged: (r) {
                  setState(() {
                    rowPerPage = r;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToCreateTimeSheet(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Homepage(),
        ));
  }
}

class TabelData extends DataTableSource {
  @override
  DataRow getRow(int index) {
    // TODO: implement getRow
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text("#cell1$index")),
      DataCell(Text("#cell2$index")),
      DataCell(Text("#cell3$index")),
      // DataCell(Text("#cell4$index")),
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => true;

  @override
  // TODO: implement rowCount
  int get rowCount => 50;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
