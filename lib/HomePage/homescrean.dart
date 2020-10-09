import 'package:App_idolconsulting/LeaveDays/leavedays.dart';
import 'package:App_idolconsulting/PaySlips/DetailsScreen.dart';
import 'package:App_idolconsulting/PaySlips/payslips.dart';
import 'package:App_idolconsulting/TravelAllowance/TravellingAllowance.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:App_idolconsulting/timeSheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../employees_main.dart';
import 'Project.dart';
import 'profile.dart';
import 'Projecttask.dart';
import 'Taskdetails.dart';
import 'package:App_idolconsulting/PerformanceAppraisal/performancemain.dart';
import 'package:date_format/date_format.dart';
import 'package:App_idolconsulting/employees_main.dart';
import 'package:App_idolconsulting/logout.dart';
import 'userprofile.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'drawer.dart';
import 'reports.dart';


class Home extends StatefulWidget {
  final Widget child;
  Home({Key key, this.child}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,

           // title: "LOGIN",
            //title: Text('reason for tech decling'),
                 content: Column(
                   mainAxisSize: MainAxisSize.min,
                   children: <Widget>[
                     GestureDetector(
                      child: TextField(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(context, new MaterialPageRoute
                            (builder: (context) => new Profile()));
                        },
                       decoration: InputDecoration(
                         border: InputBorder.none,
                         icon: Icon(Icons.person),
                         labelText: 'Profile',
                       ),
                      readOnly: true,
                     ),
          ),
                  TextField(
//                    onTap: () {
//                      Navigator.pop(context);
//                      Navigator.push(context, new MaterialPageRoute
//                        (builder: (context) => new Logout()));
//                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.launch),
                      labelText: 'Logout',
                    ),
                    readOnly: true,
                  ),
                ],
               ),
          );
        });
  }

  Indicator persentage;
  //String bar;
  Future<String> fetchProgressBar() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('userToken');

    final response = await http.get(
        'https://app.idolconsulting.co.za/idols/projects/status/5f3504f0c391b51061db90e3',
        headers: {"Accept": "application/json",
          'X_TOKEN': stringValue});

    if(response.statusCode ==200){
      setState((){
         var bar=json.decode(response.body);
        // persentage=Indicator.fromJson(bar);
        //persentage=reports.fromJson(bar);
        // persentage = json.decode(bar);
print(response.body);
      });
    }
  }

  var PictureID="https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png";
  //Map<String, dynamic> data4;
var shared;
  bool isLoading=true;

  //bool pictureLoad=true;

  //Map<String, dynamic> pic;
  UserProfile profile;

  Future<String> fetchProfileDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('userToken');

    final response = await http.get(
        'http://app.idolconsulting.co.za/idols/users/profile',
        headers: {"Accept": "application/json",
          'X_TOKEN': stringValue});

    if (response.statusCode == 200) {
      setState(() {
        var data = json.decode(response.body);
        String pictureId=data['profilePicture']['id'];
        prefs.setString("picId", pictureId);


        //profile=UserProfile.fromJson(data);
      });
      shared=prefs.getString("picId");
      PictureID='https://app.idolconsulting.co.za/idols/file/'+shared;
//      if(PictureID==null){
//        PictureID='5f3a589dc391b506469af55d';
//      }
    }
  }

  List<Tasks> task = new List<Tasks>();
  Map<String,dynamic> data3;

  Future<String> fetchTask() async {
    SharedPreferences prefs =
    await SharedPreferences.getInstance();

    String stringValue = prefs.getString('userToken');
    final response = await http.get(
        'https://app.idolconsulting.co.za/idols/tasks/1/10/DESC/createDate/5f3504f0c391b51061db90e3?keyword=',
        headers: {"Accept": "application/json",
          "X_TOKEN": stringValue,
        });

    if (response.statusCode == 200) {
      setState(() {
        // print('Token ' + stringValue);
        var data = json.decode((response.body));
        data3 = json.decode((response.body));
        for (int x = 0; x < data.length; x++) {
          var project = new Tasks(
            data3['name'].toString(),
            data3['startDate'].toString(),
            data3['endDate'].toString(),
            data3['status'].toString(),
            data3['dueDate'].toString(),
          );
          task.add(project);
        }
      });
    }
  }

  List<Project> projects = new List<Project>();
  Map<String,dynamic> detail;
  Project project;
  var name="Project Name not updated";
  Future<String> fetchProjects() async {
  bool load=true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('userToken');

    final response = await http.get(
      //'https://app.idolconsulting.co.za/idols/projects/all',
        'https://app.idolconsulting.co.za/idols/projects/5f3504f0c391b51061db90e3',
        headers: {"Accept": "application/json",
          "X_TOKEN": stringValue,
        });

    if (response.statusCode == 200) {
      setState(() {
        // print('Token from shared preferance ' + stringValue);
        var data = json.decode((response.body));
        detail = json.decode((response.body));

        for (int x = 0; x < data.length; x++) {
          var project = new Project(
              detail['name'].toString(),
              detail['id'].toString(),
              detail['createDate'].toString(),
              detail['endDate'].toString(),
              detail['description'].toString(),
            // data[x]['budget'],
              detail['status'].toString(),
              detail['logo'].toString(),
              detail['createdBy'],
              detail['manager'],
              detail['observers'],
              detail['members'],
              detail['company'],
              detail['attachments']
          );
          projects.add(project);
        }

      });
    }
  }

  List<charts.Series<Pollution, String>> _seriesData1;
  List<charts.Series<Task, String>> _seriesPieData;
  _generateData() {
    var pieData = [
      new Task('Created', 0, Colors.pinkAccent),
      new Task('Pending', 18, Colors.blue),
      //report['0']['count'],
      new Task('Done', 24, Colors.orangeAccent),
    ];

    var pieData1 = [
      new Pollution('Initialized', 0, Colors.pinkAccent),
      new Pollution('Pending', 2, Colors.blue),
      new Pollution('Complite', 0, Colors.orangeAccent),
    ];

    _seriesData1.add(
      charts.Series(
        data: pieData1,
        domainFn: (Pollution pollution, _) => pollution.task,
        measureFn: (Pollution pollution, _) => pollution.taskvalue,
        colorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(pollution.colorval),
        id: 'Daily Pollution',
        labelAccessorFn: (Pollution row, _) => '${row.taskvalue}',
      ),
    );

    _seriesPieData.add(
      charts.Series(
        data: pieData,
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'Daily Task',
        labelAccessorFn: (Task row, _) => '${row.taskvalue}',
      ),
    );
  }
  bool readOnly=true;



  @override
  void initState() {
    super.initState();
    _seriesData1 = List<charts.Series<Pollution, String>>();
    _seriesPieData = List<charts.Series<Task, String>>();
    _generateData();
    this.fetchProjects();
    //this.fetchProgressBar();
    // this.fetchTaskings();
    this. fetchTask();
    this.fetchProfileDetails();
  }
  convertDateFromString() {
    DateTime todayDate = DateTime.parse(detail['createDate'].toString());
    return formatDate(todayDate, [dd,' ',MM, ' ', yyyy]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: DrawerCodeOnly(),
          appBar: AppBar(
              backgroundColor: Colors.grey,
              bottom: TabBar(
                indicator: UnderlineTabIndicator(
                    insets: EdgeInsets.symmetric(horizontal: 16.0)),
                indicatorColor: Colors.white30,
                tabs: <Widget>[
                  Tab(text: "Project Status"),
                  Tab(text: "Task Status"),
                ],
              ),
              title: Text(
                "Welcome",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                ),

                GestureDetector(
                  onTap: () {
                    _displayDialog(context);
                  },
                 // width: 55.0,
                 // height: 60.0,
                 // color: Colors.grey,
                  child:
                  CircleAvatar(
                    radius:30,
                    backgroundColor: Colors.blue,
                    backgroundImage:NetworkImage(
                        //'http://app.idolconsulting.co.za/idols/file/' + pic['profilePicture']['id']),
                        PictureID),
                    ),
                  ),
              //  ),
              ]),

          body:
          TabBarView(children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                child: Center(
                  child: Column(children: <Widget>[
                    Text(
                      'Project Status',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.0),
                    Expanded(
                      child: charts.PieChart(_seriesData1,
                          animate: true,
                          animationDuration: Duration(seconds: 5),
                          behaviors: [
                            new charts.DatumLegend(
                              outsideJustification:
                              charts.OutsideJustification.endDrawArea,
                              horizontalFirst: false,
                              desiredMaxRows: 2,
                              cellPadding:
                              new EdgeInsets.only(right: 4.0, bottom: 4.0),
                              entryTextStyle: charts.TextStyleSpec(
                                  color: charts
                                      .MaterialPalette.purple.shadeDefault,
                                  fontFamily: 'Geoegia',
                                  fontSize: 11),
                            ),
                          ],
                          defaultRenderer: new charts.ArcRendererConfig(
                              arcWidth: 100,
                              arcRendererDecorators: [
                                new charts.ArcLabelDecorator(
                                    labelPosition:
                                    charts.ArcLabelPosition.inside)
                              ])),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new ProjectTask()));
                      },

                      child: Card(
                        elevation: 2,
                        child: Column(
                          children: [
                          Container(
                          height: 54,
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: TextField(
                              //readOnly: true,
                              // controller: _endtController,
                              decoration: new InputDecoration(
                                hintText: "search for project",
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
                        Container(
                          height: 100,
                          width: 400,
                          child: SizedBox(
    child:  ListView(
      children: <Widget>[
        Container(
        child: Column(
          children: <Widget>[
            //SizedBox(height: 60.0),
            Row(
              children: <Widget>[
                Text('Name', style: TextStyle(fontSize: 15.0),),
                SizedBox(width: 40.0),
                Text('End Date', style: TextStyle(fontSize: 15.0),),
                SizedBox(width: 40.0),
                Text('Status', style: TextStyle(fontSize: 15.0),),
                SizedBox(width: 40.0),
                Text('Manager', style: TextStyle(fontSize: 15.0),),
              ],
            ),
            SizedBox(height: 30.0),
            Row(
              children: <Widget>[
                Text(detail['name'] == null
                    ? 'Project Name not updated'
                    : detail['name']),
                SizedBox(width: 5.0),
                Text(detail['endDate'].toString()),
                SizedBox(width: 5.0),
                //Text(detail['status'].toString()),
                LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 270,
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 2000,
                  percent: 0.9,
                  center: Text("90.0%"),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Colors.orange,
                ),
                SizedBox(width: 10.0),
                Text(detail['manager']['firstName'].toString()), //createDate
              ],
            ),
          ],
        ),
      ),
    ]
    //}
                          ),
                          ),
                        ),
                        ]
                      ),
                    )
                )
                  ]),
                ),
              ),
            ),
            Padding (
              padding: EdgeInsets.all(8.0),
              child: Container(
                child: Center(
                  child: Column(children: <Widget>[
                    Text(
                      'Task Status',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.0),
                    Expanded(
                      child: charts.PieChart(_seriesPieData,
                          animate: true,
                          animationDuration: Duration(seconds: 5),
                          behaviors: [
                            new charts.DatumLegend(
                              outsideJustification:
                              charts.OutsideJustification.endDrawArea,
                              horizontalFirst: false,
                              desiredMaxRows: 2,
                              cellPadding:
                              new EdgeInsets.only(right: 4.0, bottom: 4.0),
                              entryTextStyle: charts.TextStyleSpec(
                                  color: charts
                                      .MaterialPalette.purple.shadeDefault,
                                  fontFamily: 'Geoegia',
                                  fontSize: 11),
                            ),
                          ],
                          defaultRenderer: new charts.ArcRendererConfig(
                              arcWidth: 100,
                              arcRendererDecorators: [
                                new charts.ArcLabelDecorator(
                                    labelPosition:
                                    charts.ArcLabelPosition.inside)
                              ])),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new TaskDetails()));
                      },
                      child: Card(
                        elevation: 5.0,
                        child: Column(
                          children: [
                          Container(
                          height: 54,
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: TextField(
                            //readOnly: true,
                            // controller: _endtController,
                            decoration: new InputDecoration(
                              hintText: "search for task",
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
                        Container(
                          child: SizedBox(
                            child: Container(
                              //child:  ListView(
                                //children: <Widget>[
                              //width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        width: 55.0,
                                        height: 60.0,
                                        color: Colors.white,
                                        child: CircleAvatar(
                                          radius:50,
                                          backgroundColor: Colors.blue,
                                          backgroundImage:NetworkImage(
                                              PictureID
                                             // 'https://app.idolconsulting.co.za/idols/file/5f3a589dc391b506469af55d'
                                                //  ==null ? 'https://www.w3schools.com/w3css/img_lights.jpg'
                                                 // :'http://app.idolconsulting.co.za/idols/file/' + data4['profilePicture']['id']
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(data3['content'][0]['name'].toString()==null ? '' :data3['content'][0]['name'].toString()),
                                          FlatButton(
                                            onPressed: () {},
                                            color: Colors.orange,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    20.0)),
                                            child: Text(detail['status'].toString(),
                                            ),
                                          ),
                                          SizedBox(height:15.0),
                                          Row(
                                            children: <Widget>[
                                              Text('Created:',style: TextStyle(fontSize: 15.0)),
                                              SizedBox(width: 10.0),
                                              Text(convertDateFromString()),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text('Due Date:',style: TextStyle(fontSize: 15.0)),
                                              SizedBox(width: 10.0),
                                              Text(detail['endDate'].toString()),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
//                                        Container(
//                                          alignment: Alignment.center,
//                                          padding: EdgeInsets.symmetric(
//                                              horizontal: 90.0, vertical: 10.0),
//                                          child: FlatButton(
//                                            onPressed: () {},
//                                            color: Colors.orange,
//                                            shape: RoundedRectangleBorder(
//                                                borderRadius:
//                                                    BorderRadius.circular(
//                                                        20.0)),
//                                            child: Text(task
//                                                .elementAt(index)
//                                                .status),
//                                          ),
//                                      ),
                                ],
                              ),
                          //]
                            //),
                          ),
                          //   },
                          // ),
                            ),
                        ),
                      ]),
                    )
                    ),
                  ]),
                ),
              ),
            ),
          ]),
        ),
      ),
    );

  }
  @override
  void setState(fn) {
    isLoading=false;
    super.setState(fn);
  }
}






class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}

class Pollution {
  String task;
  double taskvalue;
  Color colorval;

  Pollution(this.task, this.taskvalue, this.colorval);
}
