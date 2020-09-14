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

  List<Project> projects = new List<Project>();

  Future<String> fetchProjects() async {
    SharedPreferences prefs =
    await SharedPreferences.getInstance();

    String stringValue = prefs.getString('userToken');

    final response = await http.get(
        'https://app.idolconsulting.co.za/idols/projects/all',

        headers: {"Accept": "application/json",
          "X_TOKEN": stringValue,
        });

    if (response.statusCode == 200) {
      setState(() {
        print('Token ' + stringValue);


        var data = json.decode((response.body));

        // print(response.body);

        print(response.body);
        for (int x = 0; x < data.length; x++) {
          var project = new Project(
              data[x]['id'],
              data[x]['name'],
              data[x]['createDate'],
              data[x]['endDate'],
              data[x]['description'],
              data[x]['budget'],
              data[x]['status'],
              data[x]['logo'],
              data[x]['createdBy'],
              data[x]['manager'],
              data[x]['observers'],
              data[x]['members'],
              data[x]['company'],
              data[x]['attachments']
          );
          projects.add(project);
        }
      });
    }
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
      body:  Container(
        child: Card(
          elevation: 2,
          child: Container(
            height: 250,
            width: 500,
            child: Center(
              child: Column(
              children: <Widget>[
                //Container(
                  //child:
                  Text('Idol App',textAlign: TextAlign.center, style: TextStyle(fontSize: 24.0),),
               // ),
                RaisedButton(
                  onPressed: () {},
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(20.0)),
                  child: Text('status'),
                ),
                Text('Idol Consulting',textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                SizedBox(height: 50.0),
                Text('Start Date',textAlign: TextAlign.left,style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold)),
                Text('End Date',textAlign: TextAlign.left,style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold)),
                //Spacer(),
                SizedBox(height: 25.0),
                Text('Description',textAlign: TextAlign.left,style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold)),
              ],
            ),
              ),
            ),
          ),
      ),

    );
  }
}
