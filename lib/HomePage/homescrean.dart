import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'Project.dart';
import 'Projecttask.dart';
import 'Taskdetails.dart';
import 'package:App_idolconsulting/logout.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'drawer.dart';
import 'reports.dart';
import 'package:App_idolconsulting/UserTasks/TaskList.dart';
import 'package:date_format/date_format.dart';
import 'package:App_idolconsulting/UserProjects/UserProjects.dart';
import 'package:App_idolconsulting/UserProjects/FetchProjects.dart';
import 'package:App_idolconsulting/UserTasks/UserTasks.dart';
import 'package:App_idolconsulting/UserTasks/FetchTasks.dart';
import 'package:App_idolconsulting/UserProjects/ProjectList.dart';
import 'package:App_idolconsulting/UserTasks/Tasks.dart';
import 'package:App_idolconsulting/HomePage/Profile_details.dart';


class Home extends StatefulWidget {
  final Widget child;
  Home({Key key, this.child}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading=true;

  UserProjects userProjects;
  FetchProjects fetchUserProjects;
  Map<String,dynamic> assignedProjects;


  UserTasks userTasks;
  Taskss userTaskss;
  FetchTasks fetchTasks;
  Tasks tasks;
  Map<String, dynamic> assignedTasks;

  Map<String, dynamic> data3;
  Map<String,dynamic> users;


  Future<String> fetchDrawer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('userToken');

    final response = await http.get(
        'http://app.idolconsulting.co.za/idols/users/profile',
        headers: {"Accept": "application/json",
          'X_TOKEN': stringValue});

    if (response.statusCode == 200) {
      setState(() {
        data3 = json.decode(response.body);
      });
    }
  }


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
                            (builder: (context) => new Profile_details(data3)));
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
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, new MaterialPageRoute
                        (builder: (context) => new Logout()
                      ));
                    },
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


  var RoundedNumber;
  var New;
  var Done= " ";
  var Pending= " ";

  List<Chart> pertask = new List<Chart>();
  Map<String,dynamic> taskbar;
//  Future<String> fetcTaskbar() async {
//
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String stringValue = prefs.getString('userToken');
//
//    final response = await http.get(
//        'https://app.idolconsulting.co.za/idols/tasks/report',
//        headers: {"Accept": "application/json",
//          'X_TOKEN': stringValue});
//
//    if(response.statusCode ==200){
//      setState((){
//        var bartask =json.decode(response.body);
//        for (int x = 0; x < bartask.length; x++) {
//          var charttask = new Chart(
//            bartask[x]['done'].toString(),
//            bartask[x]['pedding'].toString(),
//            bartask[x]['new'].toString(),
//
//          );
//          pertask.add(charttask);
//        }
//      //  _generateData();
//        New=bartask[0]['count'];
//        Done=bartask[1]['count'];
//        Pending=bartask[2]['count'];
//
////        RoundedNumber = double.parse((bartask).toStringAsFixed(2));
////        RoundedNumber = RoundedNumber.round();
//      //  print(bartask[0]['count']);
//        //print(myRoundedNumber);
//      });
//
//    }
//  }



  var myRoundedNumber;

  List<Indicator> per = new List<Indicator>();
  Map<String,dynamic> cator;
  Future<String> fetchProgressBar() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('userToken');

    final response = await http.get(
        'https://app.idolconsulting.co.za/idols/projects/status/5f3504f0c391b51061db90e3',
        headers: {"Accept": "application/json",
          'X_TOKEN': stringValue});

    if(response.statusCode ==200){
      setState((){
         var bar =json.decode(response.body);

         myRoundedNumber = double.parse((bar).toStringAsFixed(2));
         myRoundedNumber = myRoundedNumber.round();
         //print(response.body);
         //print(myRoundedNumber);
      });

    }
  }


  var PictureID="https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png";
  //Map<String, dynamic> data4;
  var shared;

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



  List<Taskss> task = new List<Taskss>();
  Map<String,dynamic> taski;
var taskname=" ";
var taskdate="2020-08-17T10:50:44.227+0000";
var taskdue=" ";

  Future<String> fetchTask() async {
    SharedPreferences prefs =
    await SharedPreferences.getInstance();

    String stringValue = prefs.getString('userToken');
    final response = await http.get(

        'https://app.idolconsulting.co.za/idols/tasks/1/10/DESC/createDate?keyword=',
        headers: {"Accept": "application/json",
          "X_TOKEN": stringValue,
        });

    if (response.statusCode == 200) {
      setState(() {
        // print('Token ' + stringValue);
        var data = json.decode((response.body));

        taskname=data['content'][0]['name'];
        taskdate=data['content'][0]['createDate'];
        taskdue=data ['content'][0]['dueDate'];

        taski = json.decode((response.body));
        Map map=jsonDecode((response.body));

       userTasks=UserTasks.fromJson(map);
//        for (int x = 0; x < data.length; x++) {
//          var test = new Taskss(
//            taski['name'].toString(),
//            taski['startDate'].toString(),
//            taski['endDate'].toString(),
//            taski['status'].toString(),
//            taski['dueDate'].toString(),
//          );
//          task.add(test);
//        }
//        print("ffffffffffffffffffffffffffffffffffdd");
//        print(userTasks.project.name);
     // print(data['content'][0]['dueDate']);
      });

    }
  }

  List<Project> projects = new List<Project>();
  Map<String,dynamic> detail;
  //Project project;

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

        Map map=json.decode((response.body));

        userProjects=UserProjects.fromJson(map);

    //print(userProjects.manager.firstName + userProjects.manager.lastName);


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
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //var length=userProjects.name.length;
    var pieData = [
      new Task('Created', 0 , Colors.pinkAccent),
      new Task('Pending',19 , Colors.blue),
      //report['0']['count'],
      new Task('Done', 30, Colors.orangeAccent),
    ];
    //print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
    //print(New);
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

List<UserProjects> projectList = List();
List<UserProjects> filteredProject = List();

  List<Taskss> taskList = List();
  List<Taskss> filteredTask = List();

  @override
  void initState() {
    super.initState();

    ProjectServices.getProList().then((projectsFromServer){
      setState(() {
        filteredProject = projectsFromServer;
        projectList = filteredProject;

                // print(projectList[1].name);
      });
    });

    TaskServices.getTaskList().then((TaskFromServer){
      setState(() {
        filteredTask = TaskFromServer;
        taskList = filteredTask;

       // print(taskList[1].name);
      });
    });


    //}


    setState(() {
      //FetchProjects.getProjectDetails();

    });


    _seriesData1 = List<charts.Series<Pollution, String>>();
    _seriesPieData = List<charts.Series<Task, String>>();
    _generateData();
    this.fetchDrawer();
    this.fetchProjects();
    this.fetchTask();
    this.fetchProfileDetails();
    //this.fetcTaskbar();
    //this.fetchTasks();
    this.fetchProgressBar();
    //this.fetchTaskings();



  }
  convertDateFromString() {
    DateTime todayDate = DateTime.parse(
        taskdate
    );
    return formatDate(todayDate, [dd,' ',M, ' ', yyyy]);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: isLoading ? Center(child: CircularProgressIndicator()):
        Scaffold(
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

          body: isLoading ? Center(child: CircularProgressIndicator()):
          TabBarView(children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              //EdgeInsets.all(8.0),
              child: Container(
                child: Center(
                  child: Column(children: <Widget>[


//                    Text(
//                      'Project Status',
//                      style: TextStyle(
//                          fontSize: 15.0, fontWeight: FontWeight.bold),
//                    ),

                    SizedBox(height: 0.0),
                    Expanded(
                      child: charts.PieChart(_seriesData1,
                          animate: true,
                          animationDuration: Duration(seconds: 1),
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

                      child: isLoading ? Center(child: CircularProgressIndicator()):
                      Card(
                        elevation: 2,
                        child: Column(
                          children: [
                          Container(

                          height: 75,
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

                              onChanged: (string){
                                setState(() {
                                  projectList = filteredProject.where((c) => c.name
                                      .toLowerCase().contains(string.toLowerCase())).toList();
                                });
                              },
                              onTap: () {
                                //getEndTime(context);
                              },
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                            ),
                        ),
                        Container(
                          height: 90,
                          width: 400,
                          child: SizedBox(
                            width: 400,
    child: ListView.builder(
        itemCount: 1,
        padding: const EdgeInsets.all(0.0),
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index){
        return Container(
            //padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
           // margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable (
                  columnSpacing: 5,
                  dataRowHeight: 50,
                  headingRowHeight: 40,
                  columns: [
                    DataColumn(label: Text('Name',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                          fontWeight: FontWeight.w800
                      ),),
                    ),
                    DataColumn(label: Text('End Date',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.w800
                      ),),
                    ),
                    DataColumn(label: Text('Status',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.w800
                      ),),
                    ),
                    DataColumn(label: Text('Manager',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.w800
                      ),),
                    ),
                  ],
                  rows: List.generate(
                      projectList.length, (index) =>
                      DataRow(cells: <DataCell> [
                        DataCell(Text(
                          userProjects==null || userProjects.name==null
                    ? ' '
                    : userProjects.name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ProjectTask(
//                                    list, index
                                )),
                              );
                            }
                            ),

                        DataCell(Text(
                          userProjects==null || userProjects.endDate==null
                            ? ' ' : userProjects.endDate,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14
                          ),)),
                        DataCell(
                          LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 290,
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 2000,
                  percent: 0.2,
                  center: Text("$myRoundedNumber" ),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Colors.orange,
                          ),
                        ),
                        DataCell(Text(
                            userProjects==null || userProjects.manager.firstName==null ? ' ' : userProjects.manager.firstName
                                + " " + userProjects.manager.lastName,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14
                          ),)),
                      ])).toList()
              ),
            ),
      );
   // ]
    }
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
//                    Text(
//                      'Task Status',
//                      style: TextStyle(
//                          fontSize: 24.0, fontWeight: FontWeight.bold),
//                    ),
                    SizedBox(height: 10.0),
                    Expanded(
                      child: charts.PieChart(_seriesPieData,
                          animate: true,
                          animationDuration: Duration(seconds: 1),
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
                                builder: (context) => new TaskDetails(taski)));
                      },
                      child: isLoading ? Center(child: CircularProgressIndicator()):
                      Card(
                        elevation: 5.0,
                        child: Column(
                          children: [
                          Container(
                          height: 70,
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
                            onChanged: (string){
                              setState(() {
                                taskList = filteredTask.where((c) => c.name
                                    .toLowerCase().contains(string.toLowerCase())).toList();
                              });
                            },
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
                                          Text(
                                              taskname
                                          ),
                                          FlatButton(
                                            onPressed: () {},
                                            color: Colors.orange,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    20.0)),
                                            child: Text(
                                                 //detail['status'].toString(),
                                                userProjects==null || userProjects.status==null
                                                    ? ' '
                                                    : userProjects.status
                                            ),
                                          ),
                                          SizedBox(height:15.0),
                                          Row(
                                            children: <Widget>[
                                              Text('Created:',style: TextStyle(fontSize: 15.0)),
                                              SizedBox(width: 10.0),
                                              Text(
                                             //taskdate
                                                  convertDateFromString()
//                                                  userTasks==null || userTasks.createDate==null
//                                                      ? '17 Aug 2020'
//                                                      : userTasks.createDate
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text('Due Date:',style: TextStyle(fontSize: 15.0)),
                                              SizedBox(width: 10.0),
                                              Text(taskdue
                                                  //'31 Aug 2020'
                                                 //detail['endDate'].toString()
//                                                  userTasks==null || userTasks.endDate==null
//                                                      ? '31 Aug 2020'
//                                                      : userTasks.endDate
                                              ),
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
