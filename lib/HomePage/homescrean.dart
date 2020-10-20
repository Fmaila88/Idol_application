

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'Project.dart';
import 'profile.dart';
import 'Projecttask.dart';
import 'Taskdetails.dart';
import 'package:App_idolconsulting/logout.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'drawer.dart';
import 'reports.dart';
import 'package:App_idolconsulting/UserProjects/UserProjects.dart';
import 'package:App_idolconsulting/UserProjects/FetchProjects.dart';
import 'package:App_idolconsulting/UserTasks/UserTasks.dart';
import 'package:App_idolconsulting/UserProjects/ProjectList.dart';
import 'package:App_idolconsulting/UserTasks/Tasks.dart';

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
  Tasks tasks;

  Map<String, dynamic> assignedTasks;


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

  //Indicator persentage;
  var Indicat="";
  //Map<String, dynamic> data4;
  var persentage;
  //String bar;
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
        // String pictureId=bar['profilePicture']['id'];
         //prefs.setString("picId", pictureId);

         print(response.body);
      });
      persentage=prefs.getString("bar");
      //bar=persentage;
    }else{
      print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
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

        //Map map=jsonDecode(data);

        //tasks=Tasks.fromJson(map);


//       if(tasks!=null){
//
//        print(tasks.description);
//
//       }
//
//        userTasks=UserTasks.fromJson(map);

        for (int x = 0; x < data.length; x++) {
          var test = new Taskss(
            data3['name'].toString(),
            data3['startDate'].toString(),
            data3['endDate'].toString(),
            data3['status'].toString(),
            data3['dueDate'].toString(),
          );
          task.add(test);
        }
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

List<UserProjects> projectList = List();
List<UserProjects> filteredProject = List();

  @override
  void initState() {
    super.initState();

    ProjectServices.getProList().then((projectsFromServer){
      setState(() {
        filteredProject = projectsFromServer;
        projectList = filteredProject;

         print(projectList[1].name);
      });
    });


   // }


    setState(() {
      //FetchProjects.getProjectDetails();

    });


    _seriesData1 = List<charts.Series<Pollution, String>>();
    _seriesPieData = List<charts.Series<Task, String>>();
    _generateData();
    this.fetchProjects();
    this.fetchTask();
    this.fetchProfileDetails();
    //this.fetchTasks();
    this.fetchProgressBar();
    // this.fetchTaskings();



  }
//  convertDateFromString() {
//    DateTime todayDate = DateTime.parse(
////        userProjects==null || userProjects.endDate==null
////            ? ' '
////            : userProjects.endDate
//      //detail['createDate'].toString()
//    );
//    return formatDate(todayDate, [dd,' ',MM, ' ', yyyy]);
//  }

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


                    Text(
                      'Project Status',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),

                    SizedBox(height: 10.0),
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
                          height: 100,
                          width: 400,
                          child: SizedBox(
    child: ListView.builder(
        itemCount: projectList == null ? 0 : projectList.length,
        padding: const EdgeInsets.all(15.0),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index){
        return Container(
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
                Text(
                  //'Idol App'
                    userProjects==null || userProjects.name==null
                    ? ' '
                    : userProjects.name
                ),
                SizedBox(width: 5.0),
                Text(
                    //convertDateFromString()
                    //'31 December 2020'
                    userProjects==null || userProjects.endDate==null ? ' ' : userProjects.endDate
                ),
                SizedBox(width: 5.0),
                //Text(userProjects==null || userProjects.status==null ? ' ' : userProjects.status),
                LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 270,
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 2000,
                  percent: 0.2,
                  center: Text('33%'),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Colors.orange,
                ),
                SizedBox(width: 10.0),
                Text(userProjects==null || userProjects.manager.firstName==null ? ' ' : userProjects.manager.firstName
                    //+ " " + userProjects.manager.lastName
                ), //createDate
              ],
            ),
          ],
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
                    Text(
                      'Task Status',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
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
                                builder: (context) => new TaskDetails()));
                      },
                      child: Card(
                        elevation: 5.0,
                        child: Column(
                          children: [
                          Container(
                          height: 75,
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
                                          Text(
                                              // data3['content'][0]['name'].toString()
                                              'App UI Home Page screan'
                                              //userProjects.name
//                                              userTasks==null || userTasks.project.name==null
//                                                  ? 'Pending'
//                                                  : userTasks.project.name
                                          ),
                                          FlatButton(
                                            onPressed: () {},
                                            color: Colors.orange,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    20.0)),
                                            child: Text(
                                                'Pending'
                                                 //detail['status'].toString(),
//                                                userTasks==null || userTasks.project.name==null
//                                                    ? 'Pending'
//                                                    : userTasks.project.name
                                            ),
                                          ),
                                          SizedBox(height:15.0),
                                          Row(
                                            children: <Widget>[
                                              Text('Created:',style: TextStyle(fontSize: 15.0)),
                                              SizedBox(width: 10.0),
                                              Text(
                                                  '17 Aug 2020'
                                                  //convertDateFromString()
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
                                              Text(
                                                  '31 Aug 2020'
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
