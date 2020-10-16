import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'dart:convert';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'Back.dart';
import 'timesheetClass.dart';
import 'package:App_idolconsulting/HomePage/homescrean.dart';
import 'time_sheetclass_list.dart';
import 'HomePage/drawer.dart';
import 'gettingTimeSheetData.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: false // optional: set false to disable printing logs to console
      );
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
  TextEditingController _totalhoursController;
  TextEditingController _startController;
  TextEditingController _endtController;
  List<dynamic> _selectedEvents;
  SharedPreferences prefs;
  Future<Timesheet> timeData;
  Back back = Back();
  List<Back> listOfTimesheet = List<Back>();
  String hintValue;
  String hintEndValue;
  String comment;
  String Start_Time = "";
  var subStart_Time;
  final DateFormat dateFormat = DateFormat('dd MMMM yyyy');
  var data;
  TimeOfDay time = TimeOfDay.now();
  TimeOfDay endtime = TimeOfDay.now();
  String startTimeDate = " ";
  String Totalhours;
  Future<Null> getTime(BuildContext context) async {
    TimeOfDay timePicker = await showTimePicker(
      context: context,
      initialTime: time,
    );

    if (timePicker != null && timePicker != time) {
      setState(() {
        time = timePicker;
        if (time.hour <= 9 && time.minute <= 9) {
          _startController.text = "0${time.hour}:0${time.minute}";
        } else if (time.hour > 9 && time.minute > 9) {
          _startController.text = "${time.hour}:${time.minute}";
        } else if (time.hour <= 9 || time.minute > 9) {
          _startController.text = "0${time.hour}:${time.minute}";
        } else if (time.hour > 9 || time.minute <= 9) {
          _startController.text = "${time.hour}:0${time.minute}";
        }
        _totalhoursController.text = "${0 - time.hour}";

        startTimeDate =
            "${dateFormat.format(_controller.selectedDay)} ${_startController.text}";
      });
    }
  }

  //var getdata;
  Map<String, dynamic> getdata;
  List<List<dynamic>> dataa;
  List<GetTimeSheetData> getTimesheetData = new List<GetTimeSheetData>();
  Future<String> getTimesheet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String stringValue = prefs.getString('token');
    var response;
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "X_TOKEN": "$stringValue",
    };

    response = await http.get(
        'https://app.idolconsulting.co.za/idols/timesheetitems/items?start=2020-09-01&end=2020-11-08&_=1602701388544',
        headers: headers);

    if (response.statusCode == 200) {
      // getdata = json.decode(response.body);
      // dataa = json.decode(response.body);
//      for (int i = 0; i < getdata.length; i++) {
//        var timesheet = GetTimeSheetData(
//            getdata['comment'].toString(),
//            getdata['end'].toString(),
//            getdata['id'].toString(),
//            getdata['overtime'],
//            getdata['normal'],
//            getdata['start'].toString());
//        getTimesheetData.add(timesheet);
//      }
      //  print(dataa[0][0]['comment']);
      // daz[0][0]['comment'];
      print(response.body);
      print("sssssssssssssssssssssssssssssssssssssssss");
    } else {
      print(response.body);
      print('kkkkk');
    }
  }

  String endTimeDate = " ";
  String End_Time = " ";
  var subEnd_Time;
  String saveEvent = '';

  Future<Null> getEndTime(BuildContext context) async {
    TimeOfDay timePicker = await showTimePicker(
      context: context,
      initialTime: endtime,
    );
    if (timePicker != null && timePicker != endtime) {
      setState(() {
        endtime = timePicker;
        if (endtime.hour <= 9 && endtime.minute <= 9) {
          _endtController.text = "0${endtime.hour}:0${endtime.minute}";
        } else if (endtime.hour > 9 && endtime.minute > 9) {
          _endtController.text = "${endtime.hour}:${endtime.minute}";
        } else if (endtime.hour <= 9 || endtime.minute > 9) {
          _endtController.text = "0${endtime.hour}:${endtime.minute}";
        } else if (endtime.hour > 9 || endtime.minute <= 9) {
          _endtController.text = "${endtime.hour}:0${endtime.minute}";
        }
        _totalhoursController.text = "${endtime.hour - time.hour}";
        endTimeDate =
            "${dateFormat.format(_controller.selectedDay)} ${_endtController.text}";
      });
    }
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {});
//    _events = Map<DateTime, List<dynamic>>.from(
//        decodeMap(json.decode(prefs.getString("events") ?? "{}")));
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
            Row(
              children: <Widget>[
                RaisedButton(
                  child: Text("Download"),
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    var d1 = DateTime.now();
                    var d3 = "01 September 2020";
                    var con = dateFormat.format(d1);
                    String stringValue = prefs.getString('token');
                    var response;
                    Map<String, String> headers = {
                      "Content-Type": "application/json",
                      "Accept": "application/json",
                      "X_TOKEN": "$stringValue",
                    };
                    final status = await Permission.storage.request();
                    if (status.isGranted) {
                      final externalDir = await getExternalStorageDirectory();

                      final id = await FlutterDownloader.enqueue(
                        url:
                            'https://app.idolconsulting.co.za/idols/timesheetitems/download?end=${con}&start=${d3}',
                        savedDir: externalDir.path,
                        fileName: "timesheet.xlsm",
                        headers: headers,
                        showNotification: true,
                        openFileFromNotification: true,
                      );
                    } else {
                      print("permission deined");
                    }
                  },
                ),
              ],
            ),
            TableCalendar(
              events: _events,
              calendarStyle: CalendarStyle(
                todayColor: Colors.blueGrey,
                todayStyle:
                    TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
              ),
              onDaySelected: (date, event) {
                setState(() {
                  _selectedEvents = event;
                  saveEvent = '';
                  _showAddDialog();
                  _startController.clear();
                  // _endtController.clear();
//                  if (_eventController.text == null) {
//                    _startController.text = 'adsads';
//                    _endtController.text = 'asdsa';
//                  }
                });
              },
              calendarController: _controller,
            ),
            ..._selectedEvents.map((event) => ListTile(
                  title: Text(event),
                )),
            Text(saveEvent == null ? 'mdududu' : saveEvent),
          ],
        ),
      ),
    );
  }

  _showAddDialog() {
    _totalhoursController.clear();
    _startController.clear();
    _endtController.clear();
    _eventController.clear();
    hintValue = showValues("please select startTime", back);
    // hintEndValue = showendValues("please select startTime", back);
    // hintEndValue = showendValues("please select endTime", back);

    print("The hint " + hintValue);
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              insetPadding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: Center(
                  child: new Text(
                "${dateFormat.format(_controller.selectedDay)}" /*"${_controller.selectedDay}"*/,
                style: TextStyle(color: Colors.blueGrey),
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
                        hintText: /*"please select startTime",*/ hintValue,
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
                        hintText: hintEndValue,
                        prefixIcon: Icon(
                          Icons.query_builder,
                          color: Colors.blueGrey[800],
                        ),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueGrey[500])),
                      ),
                      onTap: () {
                        setState(() {
                          getEndTime(context);
                        });
                      },
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Text("Total Hours :"),
                        SizedBox(
                          width: 5.0,
                        ),
                        Expanded(
                          child: TextField(
                            readOnly: true,
                            controller: _totalhoursController,
                            decoration: new InputDecoration(
                              hintText: Totalhours,
                              border: InputBorder.none,
                            ),
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                          ),
                        )
                      ],
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
                        hintText: comment,
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
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          RaisedButton(
                            child: Text("close"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(
                            width: 7.0,
                          ),
                          RaisedButton(
                            child: Text("save"),
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                              String stringValue = prefs.getString('token');
                              var response;
                              Map<String, String> headers = {
                                "Content-Type": "application/json",
                                "Accept": "application/json",
                                "X_TOKEN": "$stringValue",
                              };
                              final body = jsonEncode({
                                "comment": _eventController.text,
                                "end": "$endTimeDate",
                                "endTime": _endtController.text,
                                "start": "$startTimeDate",
                                "startTime": _startController.text,
                              });
                              // print(body);
                              response = await http.put(
                                  'https://app.idolconsulting.co.za/idols/timesheetitems',
                                  headers: headers,
                                  body: body);

                              setState(() {
                                if (_events[_controller.selectedDay] != null ||
                                    _eventController.text.isNotEmpty) {
                                  _events[_controller.selectedDay] = [
                                    "${dateFormat.format(_controller.selectedDay)}",
                                    "Started: ${_startController.text}",
                                    "Ended: ${_endtController.text}",
                                    "Total Hours:${_totalhoursController.text}",
                                  ];
                                  saveEvent =
                                      '${dateFormat.format(_controller.selectedDay)}' +
                                          "\n\n\n" +
                                          'Started: ${_startController.text}' +
                                          "\n\n\n" +
                                          'Ended: ${_endtController.text}' +
                                          "\n\n\n" +
                                          'Total Hours: ${_totalhoursController.text}';
                                  _eventController.clear();
                                  Navigator.pop(context);
//                                  _startController.text = " ";
//                                  _endtController.text = " ";
                                }
                                prefs.setString(
                                    "events", json.encode(encodeMap(_events)));

                                if (response.statusCode == 200) {
                                  var data = json.decode(response.body);
                                  String timesheetId = data['timeSheet']['id'];
                                  prefs.setString("timeSheetId", timesheetId);
                                  if ("${dateFormat.format(_controller.selectedDay)}" ==
                                      "18 October 2020") {
                                    _events[_controller.selectedDay] = [
                                      "comment:00000000",
                                      "StartTime:0000000000",
                                      "EndTime:000000000"
                                    ];
                                    var time = "2020-10-18 12:00:00.000Z";
                                    Text("${_events[time]}");
                                    // _events[time];
//                                    _events[_controller.selectedDay][1];
//                                    _events[_controller.selectedDay][2];
                                  }
                                } else {
                                  throw Exception('Failed to load timesheet');
                                }
                              });

                              back = Back(
                                  startTime: "${_startController.text}",
                                  endTime: "${_endtController.text}",
                                  comments: "${_eventController.text}",
                                  currentDate:
                                      "${dateFormat.format(_controller.selectedDay)}",
                                  totalhours: "${_totalhoursController.text}");
                              listOfTimesheet.add(back);
                              _totalhoursController.clear();
                              _startController.clear();
                              _endtController.clear();
                              _eventController.clear();
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
    this.getTimesheet();
    _events = {};
    _totalhoursController = TextEditingController();
    _eventController = TextEditingController();
    _startController = TextEditingController();
    _endtController = TextEditingController();
    _controller = CalendarController();
    _selectedEvents = [];
    initPrefs();
  }

  String showValues(String hintText, Back back) {
    if (_events[_controller.selectedDay] != null ||
        _eventController.text.isNotEmpty) {
      for (int x = 0; x < listOfTimesheet.length; x++) {
        if (listOfTimesheet[x].currentDate ==
            "${dateFormat.format(_controller.selectedDay)}")
          _events[_controller.selectedDay] = [
            hintValue = listOfTimesheet[x].getStartTime(),
            hintEndValue = listOfTimesheet[x].getendTime(),
            comment = listOfTimesheet[x].getcomments(),
            Totalhours = listOfTimesheet[x].gettotalhours(),
          ];
      }
    } else {
      hintValue = hintText;
      hintEndValue = "please select endtime";
      Totalhours = " ";
    }
    return hintValue;
  }

//  String showendValues(String hintText, Back back) {
//    if (_events[_controller.selectedDay] != null ||
//        _eventController.text.isNotEmpty) {
//      for (int x = 0; x < listOfTimesheet.length; x++) {
//        if (listOfTimesheet[x].currentDate ==
//            "${dateFormat.format(_controller.selectedDay)}")
//          _events[_controller.selectedDay] = [
//            hintEndValue = listOfTimesheet[x].getendTime(),
//          ];
//      }
//    } else {
//      hintEndValue = hintText;
//    }
//    return hintEndValue;
//  }
  void tesT() {
    if (_events[_controller.selectedDay] != null ||
        _eventController.text.isNotEmpty) {
      for (int x = 0; x < listOfTimesheet.length; x++) {
        if (getTimesheetData[x].start == "12 October 2020 10:30")
          _events[_controller.selectedDay] = [
            hintEndValue = getTimesheetData[x].start,
          ];

        saveEvent = 'comment: ${getTimesheetData[x].comment}' +
            "\n\n\n" +
            'Start Time: ${getTimesheetData[x].start}' +
            "\n\n\n" +
            'End Time: ${getTimesheetData[x].end}';
      }
    } else {
      saveEvent = 'comment: ${" "}' +
          "\n\n\n" +
          'Start Time: ${" "}' +
          "\n\n\n" +
          'End Time: ${" "}';
    }
  }
}

class homeScreen extends StatefulWidget {
  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  List<ListTimeSheet> listTimeSheetArr = new List<ListTimeSheet>();
  Future<String> fetchTimeSheet() async {
    //https://app.idolconsulting.co.za/idols/timesheetitems/items?start=2020-08-30&end=2020-10-11&_=1600085537769
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('token');
    final response = await http.get(
        'https://app.idolconsulting.co.za/idols/timesheetitems/items?start=2020-08-30&end=2020-10-11&_=1600424572212',
        headers: {"Accept": "application/json", "X_TOKEN": stringValue});

    if (response.statusCode == 200) {
      setState(() {
        var data = json.decode((response.body));
        print(response.body);
      });
    } else {
      print(response.body);
    }
  }

  @override
  void initState() {
    super.initState();

    this.fetchTimeSheet();
  }

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
                onRowsPerPageChanged: (int r) {
                  setState(() {
                    this.rowPerPage = r;
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
