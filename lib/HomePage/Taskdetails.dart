import 'package:flutter/material.dart';
import 'drawer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'Project.dart';
import 'package:App_idolconsulting/UserProjects/UserProjects.dart';
import 'package:App_idolconsulting/UserProjects/FetchProjects.dart';
import 'profile.dart';
import 'package:App_idolconsulting/HomePage/homescrean.dart';

import 'package:flutter/material.dart';
import 'package:App_idolconsulting/HomePage/homescrean.dart';
import 'package:App_idolconsulting/HomePage/Profile_details.dart';
import 'package:App_idolconsulting/logout.dart';

class TaskDetails extends StatefulWidget {
  Map<String, dynamic> list;
  int index;
  TaskDetails(this.list);

  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {

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

  _displayDialog1(BuildContext context) async {
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


  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          // set up the buttons
          Widget cancelButton = FlatButton(
            onPressed: () {

            },
            color: Colors.white70,
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(0)),
            child: Text('Close'),
          );
          Widget continueButton = FlatButton(
            onPressed: () {

            },
            color: Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(0)),
            child: Text('Comment'),
          );
          return AlertDialog(
            backgroundColor: Colors.white,
            // title: "LOGIN",
            title: Text('Add Comment'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child: Text(
                      'Comment *',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                TextField(
                  obscureText: true,
          decoration: InputDecoration(
          border: OutlineInputBorder(),
                 // readOnly: true,
                ),
                ),
                Text("* Complete all required fields", style: TextStyle(fontSize: 10),
         ),
              ],
            ),
            actions: [
              cancelButton,
              continueButton,
            ],
          );
        });
  }


  UserProjects userProjects;
  FetchProjects fetchUserProjects;
  Map<String,dynamic> assignedProjects;

  TextEditingController _NameController;
  TextEditingController _DuedateController;
  TextEditingController _CreatedateController;
  TextEditingController _ComapanyeController;

 // List<Taskss> task = new List<Taskss>();
  var data;

  var PictureID="https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png";
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

  @override
  void initState() {
    super.initState();
    this.fetchProfileDetails();
    this.fetchDrawer();

    _NameController = new TextEditingController(
        text: "${widget.list['content'][0]['name']}");

    _DuedateController = new TextEditingController(
        text: "${widget.list['content'][0]['dueDate']}");

    _CreatedateController = new TextEditingController(
        text: "${widget.list['content'][0]['createDate']}");

    _ComapanyeController = new TextEditingController(
        text: "${widget.list[
          userProjects==null || userProjects.name==null
            ? ' '
            : userProjects.name]}");

//    print(userProjects.name);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: DrawerCodeOnly(),
      appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text("Tasks Details",style: TextStyle(
            color: Colors.white,
          ),),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            ),

            GestureDetector(
              onTap: () {
                _displayDialog1(context);
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
      body: Container(
        //height: 50,
        // width: 500,
        margin: EdgeInsets.only(top: 10),
        child: ListView(
          children: <Widget>[
            Container(
              child: Form(
                child: Padding(padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      //from here
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
//                            padding: EdgeInsets.symmetric(
//                                horizontal: 90.0, vertical: 0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(143, 148, 251, 3),
                                blurRadius: 3.0,
                                offset: Offset(0, 10),
                              )
                            ]),
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
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(20.0)),
                                  child: Text('New'),
                                ),
                              ),
                            ),
                            Expanded(
                              child: FlatButton(
                                onPressed: () {},
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(20.0)),
                                child: Text('Progres'),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: FlatButton(
                                  onPressed: () {},
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(20.0)),
                                  child: Text('Done'),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: FlatButton(
                                  onPressed: () {},
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(20.0)),
                                  child: Text('Escalat'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 25.0),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 10, 5),
                        child: Text(
                          'Project*',
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
                          controller: _ComapanyeController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                        child: Text(
                          'Task Title*',
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
                          //readOnly: true,
                          controller: _NameController,
                          decoration: InputDecoration(

                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                        child: Text(
                          'Task Description*',
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
                          controller: _NameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                        child: Text(
                          'Start Date*',
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
                          //controller: _CreatedateController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                        child: Text(
                          'End Date*',
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
                         controller: _DuedateController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        child: FlatButton(
                          onPressed: () {},
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(0)),
                          child: Text('Save'),
                        ),
                      ),
//                      SizedBox(height: 10.0),
                      //Text('Commentss'),
//                Card(
//                  elevation: 5.0,
//                  child: Column(
//                      children: [
//                        Container(
//                          child: SizedBox(
//                            child: Container(
//                              //child:  ListView(
//                              //children: <Widget>[
//                              //width: MediaQuery.of(context).size.width,
//                              child: Row(
//                                children: <Widget>[
//                                  Row(
//                                    children: <Widget>[
//                                      Container(
//                                        width: 55.0,
//                                        height: 60.0,
//                                        color: Colors.white,
//                                        child: CircleAvatar(
//                                          radius:50,
//                                          backgroundColor: Colors.blue,
//                                          backgroundImage:NetworkImage(
//                                              PictureID
//                                            // 'https://app.idolconsulting.co.za/idols/file/5f3a589dc391b506469af55d'
//                                            //  ==null ? 'https://www.w3schools.com/w3css/img_lights.jpg'
//                                            // :'http://app.idolconsulting.co.za/idols/file/' + data4['profilePicture']['id']
//                                          ),
//                                        ),
//                                      ),
//                                      Column(
//                                        children: <Widget>[
//                                          Text("oooo"
//                                            //  taskname
//                                          ),
//                                          FlatButton(
//                                            onPressed: () {},
//                                            color: Colors.orange,
//                                            shape: RoundedRectangleBorder(
//                                                borderRadius:
//                                                BorderRadius.circular(
//                                                    20.0)),
//                                            child: Text("oooo"
//                                              //detail['status'].toString(),
////                                                userProjects==null || userProjects.status==null
////                                                    ? ' '
////                                                    : userProjects.status
//                                            ),
//                                          ),
//                                          SizedBox(height:15.0),
//                                          Row(
//                                            children: <Widget>[
//                                              Text('Created:',style: TextStyle(fontSize: 15.0)),
//                                              SizedBox(width: 10.0),
//                                              Text("oooo"
//                                                //taskdate
//                                                  //convertDateFromString()
////                                                  userTasks==null || userTasks.createDate==null
////                                                      ? '17 Aug 2020'
////                                                      : userTasks.createDate
//                                              ),
//                                            ],
//                                          ),
//                                          Row(
//                                            children: <Widget>[
//                                              Text('Due Date:',style: TextStyle(fontSize: 15.0)),
//                                              SizedBox(width: 10.0),
//                                              Text(
//                                                '31 Aug 2020'
//                                                //detail['endDate'].toString()
////                                                  userTasks==null || userTasks.endDate==null
////                                                      ? '31 Aug 2020'
////                                                      : userTasks.endDate
//                                              ),
//                                            ],
//                                          ),
//                                        ],
//                                      ),
//                                    ],
//                                  ),
////                                        Container(
////                                          alignment: Alignment.center,
////                                          padding: EdgeInsets.symmetric(
////                                              horizontal: 90.0, vertical: 10.0),
////                                          child: FlatButton(
////                                            onPressed: () {},
////                                            color: Colors.orange,
////                                            shape: RoundedRectangleBorder(
////                                                borderRadius:
////                                                    BorderRadius.circular(
////                                                        20.0)),
////                                            child: Text(task
////                                                .elementAt(index)
////                                                .status),
////                                          ),
////                                      ),
//                                ],
//                              ),
//                              //]
//                              //),
//                            ),
//                            //   },
//                            // ),
//                          ),
//                        ),
//                      ]),
//                ),
                      Card(
                        child: Container(
                          width: 500,
                          height: 100,
                          child: SizedBox(
                            // child: Row()
                            child: Container(
                              child: Column(
                                children: [
                                  Center(
                                      child: Text("Comments")),
                                  Center(
                                    child: Container(
                                      child: FlatButton(
                                        onPressed: () {
                                            _displayDialog(context);
                                        },
                                        color: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(0)),
                                        child: Text('Add Comment'),
                                      ),
                                    ),
                                  )
                                ],
                              ),

                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),

    );
  }
}
