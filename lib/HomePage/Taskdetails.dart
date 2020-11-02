import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'Project.dart';
import 'package:App_idolconsulting/UserProjects/UserProjects.dart';
import 'package:App_idolconsulting/UserProjects/FetchProjects.dart';
import 'package:App_idolconsulting/HomePage/Profile_details.dart';
import 'package:App_idolconsulting/logout.dart';
import 'package:App_idolconsulting/HomePage/Taskcomment.dart';
import 'package:date_format/date_format.dart';
import 'drawer.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';


class TaskDetails extends StatefulWidget {
  Map<String, dynamic> list;
  int index;
  TaskDetails(this.list);

  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {

  TextEditingController _commentController;
  TextEditingController _createDateController;
  TextEditingController _idController;

 // List<bool> _selections = List.generate(4, (_) => false);
  List<bool> isSelected;
  String _myAccount = " Enabled";
  Color _myColor = Colors.blue;

//  Future<List> getData() async {
//    final response =
//    await http.get("https://app.idolconsulting.co.za/idols/comments/1/10/ASC/id/5f3a6104c391b506469af574");
//    return json.decode(response.body);
//  }



  UserProjects userProjects;
  FetchProjects fetchUserProjects;
  Map<String,dynamic> assignedProjects;


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


  List<Taskss> task = new List<Taskss>();
  Map<String,dynamic> taski;
  var fiona;
 var projectname=" ";

  Future<String> fetchTask() async {
    SharedPreferences prefs =
    await SharedPreferences.getInstance();

    String stringValue = prefs.getString('userToken');
    final response = await http.get(

        'https://app.idolconsulting.co.za/idols/tasks/5f3a6104c391b506469af574',
        headers: {"Accept": "application/json",
          "X_TOKEN": stringValue,
        });

    if (response.statusCode == 200) {
      setState(() {
        // print('Token ' + stringValue);
         fiona = json.decode((response.body));

        projectname=fiona['project']['name'];

         _ComapanyeController.text=projectname;
        taski = json.decode((response.body));
       // Map map=jsonDecode((response.body));

       // userTasks=UserTasks.fromJson(map);
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
        // print(fiona['project']['name']);
      });

    }
  }

  List<Taskcoment> commenting = new List<Taskcoment>();
  Map<String,dynamic> api;

  var comment=" ";
  var createdate="2020-10-22T07:41:49.456+0000";
  var id=" ";

  Future<String> fetchTaskComment() async {
    SharedPreferences prefs =
    await SharedPreferences.getInstance();

    String stringValue = prefs.getString('userToken');
    final response = await http.get(

        'https://app.idolconsulting.co.za/idols/comments/1/10/ASC/id/5f3a6104c391b506469af574',
        headers: {"Accept": "application/json",
          "X_TOKEN": stringValue,
        });

    if (response.statusCode == 200) {
      setState(() {
        // print('Token ' + stringValue);
        var data = json.decode((response.body));

        comment=data['content'][0]['comment'];
        createdate=data['content'][0]['createDate'];
//        id=data ['content'][0]['dueDate'];

        api = json.decode((response.body));

        for (int x = 0; x < data.length; x++) {
          var testcomment = new Taskcoment(
            api['comment'].toString(),
            api['createDate'].toString(),
            api['id'].toString(),
          );
          commenting.add(testcomment);
        }
      // print("ffffffffffffffffffffffffffffffffffdd");
        //print(response.body);
        // print(data['content'][0]['createDate']);
      });

    }
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

  _displayDialogerror(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.red,

            // title: "LOGIN",
            //title: Text('reason for tech decling'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
//                GestureDetector(
//                  child: TextField(
//                    onTap: () {
//                      Navigator.pop(context);
//                      Navigator.push(context, new MaterialPageRoute
//                        (builder: (context) => new Profile_details(data3)));
//                    },
//                    decoration: InputDecoration(
//                      border: InputBorder.none,
//                      icon: Icon(Icons.person),
//                      labelText: 'Profile',
//                    ),
//                    readOnly: true,
//                  ),
//                ),
                TextField(
//                  onTap: () {
//                    Navigator.pop(context);
//                    Navigator.push(context, new MaterialPageRoute
//                      (builder: (context) => new Logout()
//                    ));
//                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.launch),
                    labelText: 'Not Premited',
                  ),
                  readOnly: true,
                ),
              ],
            ),
          );
        });
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
                "comment": _commentController.text,
                "createDate": _CreatedateController.text,
                "id": "5f97e783c391b506a2edbebb",
              });
              // print(body);
              response = await http.put(
                  'https://app.idolconsulting.co.za/idols/comments',
                  headers: headers,
                  body: body);

              setState(() {

                if (response.statusCode == 200) {
                  var data = json.decode(response.body);
                  print(response.body);
                  Navigator.pop(context);

                } else {
                  throw Exception('Failed to load timesheet');
                }
              });

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
                    child: TextField(
                     controller: _commentController,
                      decoration: new InputDecoration(
                       // hintText: comment,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueGrey)),
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                ),
//                TextField(
//                  obscureText: true,
//          decoration: InputDecoration(
//          border: OutlineInputBorder(),
//                 // readOnly: true,
//                ),
//                ),
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

//  List<Taskstatus> errortask = new List<Taskstatus>();
//  Map<String,dynamic> displayerror;
//
// var message=" ";
//  var createdate=" ";
//  var id=" ";
//
//  Future<String> fetchTaskErro() async {
//    SharedPreferences prefs =
//    await SharedPreferences.getInstance();
//
//    String stringValue = prefs.getString('userToken');
//    final response = await http.get(
//
//        'https://app.idolconsulting.co.za/idols/tasks',
//        headers: {"Accept": "application/json",
//          "X_TOKEN": stringValue,
//        });
//
//    if (response.statusCode == 200) {
//      setState(() {
//        // print('Token ' + stringValue);
//        var data = json.decode((response.body));
//
//        message=data['message'];
////        createdate=data['content'][0]['createDate'];
////        id=data ['content'][0]['dueDate'];
//        displayerror = json.decode((response.body));
//
//        for (int x = 0; x < data.length; x++) {
//          var erros = new Taskstatus(
//            displayerror['message'].toString(),
//            displayerror['status'].toString(),
//            displayerror['timestamp'].toString(),
//          );
//          errortask.add(erros);
//        }
//         print("ffffffffffffffffffffffffffffffffffdd");
//        print(response.body);
//        print(data['message']);
//      });
//
//    }else{
//      print("mmmm");
//      print(response.body);
//
//    }
//  }

  @override
  void initState() {
    // this is for 3 buttons, add "false" same as the number of buttons here
    isSelected = [false, true, false, false];
    super.initState();
    this.fetchProfileDetails();
    this.fetchDrawer();
    this.fetchTaskComment();
    this.fetchTask();
//    build(context);
    //this.fetchTaskErro();
    _commentController = TextEditingController();
    _createDateController = TextEditingController();
    _idController = TextEditingController();

    _NameController = new TextEditingController(
        text: "${widget.list['content'][0]['name']}");

    _DuedateController = new TextEditingController(
        text: "${widget.list['content'][0]['dueDate']}");

    _CreatedateController = new TextEditingController(
        text: "${widget.list['content'][0]['createDate']}");

    _ComapanyeController = new TextEditingController();
   // print([0].userProjects.name);

  }

  convertDateFromString() {
    DateTime todayDate = DateTime.parse(
        createdate
    );
    return formatDate(todayDate, [dd,' ',M, ' ', yyyy, ' ', hh, ':', nn]);
  }

  final List<String> tripeList = ["fiona","freddy" ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerCodeOnly(),
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
              child: Padding(padding: EdgeInsets.all(5.0),
                child: Column(
                  children: <Widget>[
                    Container(
                  child: ToggleButtons(
                    children: <Widget>[
                      // first toggle button
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'New',
                        ),
                      ),
                      // second toggle button
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'In Progress',
                        ),
                      ),
                      // third toggle button
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Done',
                        ),
                      ),
                      // third toggle button
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Escalated',
                        ),
                      ),
                    ],
                    // logic for button selection below
                    onPressed: (int index) {
                      _displayDialogerror(context);
                      setState(() {
                        for (int i = 0; i < isSelected.length; i++) {
                          isSelected[i] = i == index;
                        }
                      });
                    },
                    isSelected: isSelected,
                    borderRadius: BorderRadius.circular(30),
                    borderWidth: 2,
                    //borderColor: Colors.black,
                    selectedBorderColor: Colors.blueAccent,
                    selectedColor: Colors.white,
                      color: Colors.black,
                      fillColor: Colors.blue,
                    splashColor: Colors.blueAccent,
                  ),

//                    ToggleButtons(
//                        children: [
//                          Text("New"),
//                          Text("In Progress"),
//                          Text("Done"),
//                          Text("Escalated"),
//                        ],
//                        //isSelected: null
//                   // ),
//                        isSelected: _selections,
//
//                        onPressed: (int index){
//                      setState(() {
//
//
//                        if(_selections[1] = true){
//                          return;
//                        } else {
//                          _selections[index] = !_selections[index];
//                        }
//
////                      while(_selections[index] = false){
////                        _selections[index] = _selections[index];
////                      }
//
//
//
//
////                        if (_myColor == Colors.green) {
////                          _myAccount = "Account Disabled";
////                          _myColor = Colors.orange;
////                        }
////                        else {
////                          _myAccount = "Account Enabled";
////                          _myColor = Colors.green;
//
////                         if(_selections != _selections) {
////                           return;
////                         } else {
////                           _selections[index] = !_selections[index];
////                         }
//
////                        _selections[1] = !_selections[index];
////                       }
//                      });
//                        },
//                      borderRadius: BorderRadius.circular(30),
//                      borderWidth: 2,
//                      borderColor: Colors.black,
//                      selectedBorderColor: Colors.blueAccent,
//                      selectedColor: Colors.white,
//                        color: Colors.black,
//                        fillColor: Colors.blue,
//                      splashColor: Colors.blueAccent,
//                    ),
                  ),
                    SizedBox(height: 25.0),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 270, 5),
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
                      margin: EdgeInsets.fromLTRB(10, 10, 270, 5),
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
                      margin: EdgeInsets.fromLTRB(10, 10, 200, 5),
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
                      margin: EdgeInsets.fromLTRB(10, 10, 270, 5),
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
                      margin: EdgeInsets.fromLTRB(10, 10, 270, 5),
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
                    SizedBox(height: 15.0),
                    Row(
                      children: <Widget> [
                        Container(
                          padding: EdgeInsets.fromLTRB(125, 5, 80, 12),
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
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: RaisedButton(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            onPressed: getFilePath,
                            child: Text(
                              'Browse',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
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
                        height: 200,
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
                                ),
//                                  Container(
//                                    child: new ListView.builder(
//                                        itemCount: tripeList.length,
//                                        itemBuilder: (BuildContext context,int index)
//                                        => buildTripCard(context, index)
//                                    ),
//                                      ),

                                  Card(
                                    elevation: 5.0,
                                    child: Column(
                                        children: [
                                          Container(
                                            height: 20,
                                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
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
//
////                                                ListView.builder(
////                                                  itemCount: commenting == null ? 0 : commenting.length,
////                                                  itemBuilder: (context, i) {
////                                                    return new ListTile(
////                                                      title: new Container(
////                                                        //padding: const EdgeInsets.only(top: 5.0),
////                                                        child: GestureDetector(
//////              onTap: () => Navigator.of(context).push(
////////                new MaterialPageRoute(
////////                  builder: (BuildContext context) =>
////////                  //new Detail(list: list, index: i),
////////                ),
//////              ),
//                                                          child: new Card(
//                                                            child: new ListTile(
//                                                              title: new Row(
//                                                                children: [
//                                                                  Text("pppp"),
//                                                                  SizedBox(
//                                                                    width: 5.0,
//                                                                  ),
//                                                                 // Text(convertDateFromString()),
//                                                                ],
//                                                              ),
//                                                              leading: CircleAvatar(
//                                                                radius:50,
//                                                                backgroundColor: Colors.blue,
//                                                                backgroundImage:NetworkImage(
//                                                                    PictureID
//                                                                  // 'https://app.idolconsulting.co.za/idols/file/5f3a589dc391b506469af55d'
//                                                                  //  ==null ? 'https://www.w3schools.com/w3css/img_lights.jpg'
//                                                                  // :'http://app.idolconsulting.co.za/idols/file/' + data4['profilePicture']['id']
//                                                                ),
//                                                              ),
//                                                            ),
//                                                          ),
//                                                        ),
//                                                      ),
//                                                      //
//                                                    );
//                                                  },
//                                                ),
//
////                                                        Flexible(
////                                                          child: new FutureBuilder<List>(
////                                                            future: fetchTaskComment(),
////                                                            builder: (context, snapshot) {
////                                                              if (snapshot.hasError) print(snapshot.error);
////
////                                                              return snapshot.hasData
////                                                                  ? new ItemList(list: snapshot.data)
////                                                                  : new Center(
////                                                                child: new CircularProgressIndicator(),
////                                                              );
////                                                            },
////                                                          ),
////                                                        )
//

//    Container(
//    child: new ListView.builder(
//    itemCount: tripeList.length,
//    itemBuilder: (BuildContext context,int index)
//    => buildTripCard(context, index)
//    ),
//    ),

//Card(
                                 Column(
                                  children: <Widget>[

                                    Text(comment
                                      //api['content'][0]['comment'].toString(),
                                    ),
                                    SizedBox(height:15.0),
                                    Row(
                                      children: <Widget>[
                                        Text('Created:',style: TextStyle(fontSize: 15.0)),
                                        SizedBox(width: 10.0),
                                        Text(convertDateFromString()
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
//),


//
//                                                                            ],
//                                                                            ),
//                                                                            ],
//                                                                            ),
//
                                                                            //]
                                                                            //),


                                                                            ]
                                                                            ),
                                                                            //   },
                                                                            // ),
                                                                             ]
                                                                            ),
                                                                            ),
                                                                            ),
                                                                            )

  //  )
                                                                          ],
                                                                          ),

                                                                          ),
                          ]
                                                                          ),
                                                                          ),
                                                                          ),
                                                                          ),
                                                                          )
                                                                        //  },
             ] ),
            ),
          ),
   // ],
    ),
    ]
        ),
      ),

    );
  }
  Widget buildTripCard (BuildContext context, int index){
    return Container(
        child: Card(
          child: Column(
            //hereCode
            children: <Widget>[
              Text(index.toString()),
              Text(tripeList[index]),
            ],
          ),
        )
    );
  }
}




//class ItemList extends StatelessWidget {
//  final List list;
//  ItemList({this.list});
//  @override
//  Widget build(BuildContext context) {
//    return new ListView.builder(
//      itemCount: list == null ? 0 : list.length,
//      itemBuilder: (context, i) {
//        return new ListTile(
//          title: new Container(
//            //padding: const EdgeInsets.only(top: 5.0),
//            child: GestureDetector(
////              onTap: () => Navigator.of(context).push(
//////                new MaterialPageRoute(
//////                  builder: (BuildContext context) =>
//////                  //new Detail(list: list, index: i),
//////                ),
////              ),
//              child: new Card(
//                child: new ListTile(
//                  title: new Row(
//                    children: [
//                      Text("ok"),
//                      SizedBox(
//                        width: 5.0,
//                      ),
//                      Text("oo"),
//                    ],
//                  ),
//                  leading: CircleAvatar(
//
//                    radius:50,
//                    backgroundColor: Colors.blue,
////                    backgroundImage:NetworkImage(
////                        PictureID
////                      // 'https://app.idolconsulting.co.za/idols/file/5f3a589dc391b506469af55d'
////                      //  ==null ? 'https://www.w3schools.com/w3css/img_lights.jpg'
////                      // :'http://app.idolconsulting.co.za/idols/file/' + data4['profilePicture']['id']
////                    ),
//                  ),
//                ),
//              ),
//            ),
//          ),
//        );
//      },
//    );
//  }
//}
