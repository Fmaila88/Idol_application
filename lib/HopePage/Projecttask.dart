import 'package:flutter/material.dart';
import 'homescrean.dart';
import 'Project.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ProjectTask extends StatefulWidget {

  _ProjectTaskState createState() => _ProjectTaskState();
}

class _ProjectTaskState extends State<ProjectTask> {


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
        print('Token ' + stringValue);

        var data = json.decode((response.body));

        data3 = json.decode((response.body));

        //print(detail['endDate'].toString());


        // print('createDate');
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


  Map<String, dynamic> data4;
  bool isLoading=true;

  Future<String> fetchDrawer() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('userToken');

    final response = await http.get(
        'http://app.idolconsulting.co.za/idols/users/profile',
        headers: {"Accept": "application/json",
          'X_TOKEN': stringValue});

    if(response.statusCode ==200){
      setState((){
        data4=json.decode(response.body);

      });
    }
  }

  List<Project> projects = new List<Project>();

  Map<String,dynamic> detail;

  Future<String> fetchProjects() async {
    SharedPreferences prefs =
    await SharedPreferences.getInstance();

    String stringValue = prefs.getString('userToken');

    final response = await http.get(
      //'https://app.idolconsulting.co.za/idols/tasks/1/10/DESC/createDate/5f3504f0c391b51061db90e3?keyword=',
        //'https://app.idolconsulting.co.za/idols/projects/all',
       'https://app.idolconsulting.co.za/idols/projects/5f3504f0c391b51061db90e3',

        headers: {"Accept": "application/json",
          "X_TOKEN": stringValue,
        });

    if (response.statusCode == 200) {
      setState(() {
        print('Token ' + stringValue);

        var data = json.decode((response.body));

         detail = json.decode((response.body));

       // print(detail['endDate'].toString());


       // print('createDate');
        for (int x = 0; x < data.length; x++) {
          var project = new Project(
              detail['name'].toString(),
              detail['id'].toString(),
              detail['startDate'].toString(),
              detail['endDate'].toString(),
              detail['description'].toString(),
              detail['status'].toString(),
       //       detail['budget'],
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
  @override
  void initState() {
    super.initState();
    this.fetchProjects();
    this.fetchDrawer();
    this.fetchTask();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       drawer: DrawerCodeOnly(),
      appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text("Project Tasks",style: TextStyle(
            color: Colors.white,
          ),),
          actions:<Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
            ),

            FlatButton(
              child: new Text('Logout',style: new TextStyle(fontSize:17.0,color:Colors.white)),
              onPressed: (){
                //AuthService().signOut();
              },
            ),
          ]),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              // bodyDate(),
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
                                child: Text(detail['name'].toString(),
                                  textAlign: TextAlign.center, style: TextStyle(fontSize: 24.0),),
                              ),
                              Center(
                                child: RaisedButton(
                                  onPressed: () {},
                                  color: Colors.orange,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(20.0)),
                                  child: Text(detail['status'].toString(),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(detail['company']['name'].toString(),
                                  textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                              ),
                              SizedBox(height: 60.0),
                              Row(
                                children: <Widget>[
                                  Text('Start Date:',style: TextStyle(fontSize: 17.0),),
                                  SizedBox(width: 70.0),
                                  Text(detail['createDate'].toString()),
                                ],
                              ),
                              SizedBox(height: 20.0),
                              Row(
                                children: <Widget>[
                                  Text('End Date:',style: TextStyle(fontSize: 17.0)),
                                  SizedBox(width: 90.0),
                                  Text(detail['endDate'].toString()),//createDate
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
                      child: RaisedButton(
                    onPressed: () {},
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    ),
                             child: Text('Add Task'),
              ),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Center(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Filter tasks',
                            border: OutlineInputBorder()),
                      ),
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
                                              backgroundImage:NetworkImage('http://app.idolconsulting.co.za/idols/file/' + data4['profilePicture']['id']),
                                            ),
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Text(data3['content'][0]['name'].toString()),
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
                                                  Text(detail['createDate'].toString()),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Text('Due Date:',style: TextStyle(fontSize: 15.0)),
                                                  SizedBox(width: 10.0),
                                                  Text(detail['endDate'].toString()),
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
