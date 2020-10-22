import 'package:flutter/material.dart';
import 'Project.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:date_format/date_format.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:App_idolconsulting/logout.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:App_idolconsulting/UserProjects/UserProjects.dart';
import 'package:App_idolconsulting/UserProjects/FetchProjects.dart';
import 'package:App_idolconsulting/UserTasks/UserTasks.dart';
import 'package:App_idolconsulting/UserTasks/FetchTasks.dart';
import 'package:App_idolconsulting/HomePage/Profile_details.dart';

class ProjectTask extends StatefulWidget {

  _ProjectTaskState createState() => _ProjectTaskState();
}

class _ProjectTaskState extends State<ProjectTask> {

  UserProjects userProjects;
  FetchProjects fetchUserProjects;
  Map<String,dynamic> assignedProjects;

  FetchTasks fetchTasks;
  UserTasks userTasks;
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


  List<Taskss> task = new List<Taskss>();

  Map<String,dynamic> data6;
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

        var data = json.decode((response.body));
        taskname=data['content'][0]['name'];
        taskdate=data['content'][0]['createDate'];
        taskdue=data ['content'][0]['dueDate'];

        data6 = json.decode((response.body));

        Map map=json.decode((response.body));

        userTasks=UserTasks.fromJson(map);

        //print(detail['endDate'].toString());


        // print('createDate');
//        for (int x = 0; x < data.length; x++) {
////          var project = new Taskss(
////            data3['name'].toString(),
////            data3['startDate'].toString(),
////            data3['endDate'].toString(),
////            data3['status'].toString(),
////            data3['dueDate'].toString(),
////          );
//          task.add(project);
//        }
       // print(data['content'][0]['name']);
      });
    }

  }

  var myRoundedNumber;

 // List<Indicating> per = new List<Indicating>();
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

        myRoundedNumber = double.parse((bar).toStringAsFixed(1));
        myRoundedNumber = myRoundedNumber.round();

//         print(myRoundedNumber);
      });

    }
  }


  var PictureID="https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png";
  var shared;
  bool isLoading=true;

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

    }
  }

  List<Project> projects = new List<Project>();
  Map<String,dynamic> detail;
  Project project;

  Future<String> fetchProjects() async {
    SharedPreferences prefs =
    await SharedPreferences.getInstance();

    String stringValue = prefs.getString('userToken');

    final response = await http.get(
        'https://app.idolconsulting.co.za/idols/projects/5f3504f0c391b51061db90e3',

        headers: {"Accept": "application/json",
          "X_TOKEN": stringValue,
        });

    if (response.statusCode == 200) {
      setState(() {

        var data = json.decode((response.body));
        detail = json.decode((response.body));

        Map map=json.decode((response.body));

        userProjects=UserProjects.fromJson(map);

        for (int x = 0; x < data.length; x++) {
          var project = new Project(

            detail['name'].toString(),
            detail['id'].toString(),
            detail['startDate'].toString(),
            detail['endDate'].toString(),
            detail['description'].toString(),
            detail['status'].toString(),
              //detail['budget'],
              detail['logo'],
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
  convertDateFromString() {
    DateTime todayDate = DateTime.parse(
        taskdate
    );
    return formatDate(todayDate, [dd,' ',M, ' ', yyyy]);
  }
  @override
  void initState() {
    super.initState();
    this.fetchProjects();
    this.fetchProfileDetails();
    this.fetchTask();
    this.fetchProgressBar();
    this.fetchDrawer();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // drawer: DrawerCodeOnly(),
      appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text("Project Tasks",style: TextStyle(
            color: Colors.white,
          ),),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            ),

            GestureDetector(
              onTap: () {
                _displayDialog(context);
              },
              child:
              CircleAvatar(
                radius:30,
                backgroundColor: Colors.blue,
                backgroundImage:NetworkImage(
                  //'http://app.idolconsulting.co.za/idols/file/' + pic['profilePicture']['id']),
                    PictureID),
              ),
            ),
          ]),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Card(
              elevation:2,
              child: Container(
                height: 300,
                width: 500,
                child:SizedBox(
                  child:  Container(
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Text(userProjects==null || userProjects.name==null
                              ? ' '
                              : userProjects.name,
                            //detail['name'].toString(),
                            textAlign: TextAlign.center, style: TextStyle(fontSize: 24.0),),
                        ),
                        Center(
                          child: RaisedButton(
                            onPressed: () {},
                            color: Colors.orange,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(20.0)),
                            child: Text(userProjects==null || userProjects.status==null
                                ? ' '
                                : userProjects.status
                              //detail['status'].toString(),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            userProjects==null || userProjects.company.name==null ? '' : userProjects.company.name,
                            //detail['company']['name'].toString(),
                            textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                        ),
                        SizedBox(height: 20.0),
                        Center(
                          child: Column(
                            children: <Widget>[
                              //Padding(
                               // padding: EdgeInsets.all(15.0),
                              LinearPercentIndicator(
                                width: MediaQuery.of(context).size.width - 50,
                                animation: true,
                                lineHeight: 20.0,
                                animationDuration: 2000,
                                percent: 0.2,
                                center: Text("$myRoundedNumber"),
                                linearStrokeCap: LinearStrokeCap.roundAll,
                                progressColor: Colors.orange,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          children: <Widget>[
                            Text('Start Date:',style: TextStyle(fontSize: 17.0),),
                            SizedBox(width: 90.0),
                            Text(
                                convertDateFromString()
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          children: <Widget>[
                            Text('End Date:',style: TextStyle(fontSize: 17.0)),
                            SizedBox(width: 90.0),
                            Text(
                                //detail['endDate'].toString()
                                userProjects==null || userProjects.endDate==null ? ' ' : userProjects.endDate
                            ),//createDate
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          children: <Widget>[
                            Text('Description:',style: TextStyle(fontSize: 17.0)),
                            SizedBox(width: 5.0),
                            //Text(detail['endDate'].toString()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Center(
                    child: RaisedButton.icon(
                      onPressed: () {},
                      color: Colors.blue,
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      shape: RoundedRectangleBorder(
                      ),
                      label: Text(
                        'Add Task' ,style: TextStyle(
                        color: Colors.white
                      ),
                      ),
                      //child: Text('Add Task'),
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: 'Filter tasks',
                              border: OutlineInputBorder()),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: 'Filter by status',
                              border: OutlineInputBorder()),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Card(
                    elevation: 5.0,
                    child: Container(
                      height: 150,
                      width: 500,
                      child: SizedBox(
//                          child: ListView.builder(
//                            itemCount: projects == null ? 0 : projects.length,
//                            //scrollDirection: Axis.horizontal,
//                            //shrinkWrap: true,
//                            itemBuilder: (BuildContext context, int index) {
//                              return Container(
                        child: Container(
                          //width: MediaQuery.of(context).size.width,
                          // padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 50.0,
                                    height: 60.0,
                                    color: Colors.white,
                                    child: isLoading ? Center(child: CircularProgressIndicator()):
                                    CircleAvatar(
                                      radius:50,
                                      backgroundColor: Colors.blue,
                                      backgroundImage:NetworkImage(PictureID),
                                    ),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(taskname
//                                          userTasks==null || userTasks.name==null
//                                          ? 'App UI Home page screen'
//                                          : userTasks.name
                                      ),
                                      FlatButton(
                                        onPressed: () {},
                                        color: Colors.orange,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(
                                                20.0)),
                                        child: Text(userProjects==null || userProjects.status==null
                                            ? ' '
                                            : userProjects.status
                                          //detail['status'].toString(),
                                        ),
                                      ),
                                      SizedBox(height:15.0),
                                      Row(
                                        children: <Widget>[
                                          Text('Created:',style: TextStyle(fontSize: 15.0)),
                                          SizedBox(width: 10.0),
                                          Text(
                                              convertDateFromString()
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text('Due Date:',style: TextStyle(fontSize: 15.0)),
                                          SizedBox(width: 10.0),
                                          Text(taskdue
                                          ),
                                        ],
                                      ),
//                                              Text('Created:',style: TextStyle(fontSize: 17.0)),
//                                              SizedBox(width: 10.0),
//                                              Text(detail['endDate'].toString()),
//                                              Text('Created:',style: TextStyle(fontSize: 17.0)),
//                                              SizedBox(width: 10.0),
//                                              Text(detail['endDate'].toString()),
                                    ],
                                  ),
                                  //SizedBox(height: 5.0),


//                                          Row(
//                                            children: <Widget>[
//                                              Text('Due Date:',style: TextStyle(fontSize: 17.0)),
//                                              SizedBox(width: 5.0),
//                                              Text(detail['endDate'].toString()),
//                                            ],
//                                          ),
//                                          SizedBox(height: 20.0),
//                                          Row(
//                                            children: <Widget>[
//                                              Text('Due Date:',style: TextStyle(fontSize: 17.0)),
//                                              SizedBox(width: 5.0),
//                                              //Text(detail['endDate'].toString()),
//                                            ],
//                                          ),
//                                          DataTable(
//                                            columns: [
//                                              DataColumn(label: Text(data3['content'][0]['name'].toString())),
//                                              DataColumn(label:  FlatButton(
//                                              onPressed: () {},
//                                              color: Colors.orange,
//                                              shape: RoundedRectangleBorder(
//                                              borderRadius:
//                                              BorderRadius.circular(
//                                              20.0)),
//                                                child: Text(detail['status'].toString(),
//                                                ),
//                                              )),
//                                              DataColumn(label: Text(data3['content'][0]['name'].toString())),
//                                            ],
//                                            rows: [
//                                              DataRow(cells: [
//                                                DataCell(Text(data3['content'][0]['dueDate'].toString(),)),
//                                                DataCell(Text(data3['content'][0]['dueDate'].toString(),)),
//                                                DataCell(Text(data3['content'][0]['dueDate'].toString(),)),
//                                              ])
//                                            ],
//                                          ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
