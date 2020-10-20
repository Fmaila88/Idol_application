import 'package:App_idolconsulting/PaySlips/NewRole.dart';
import 'package:App_idolconsulting/TravelAllowance/Admin/Admin.dart';

import 'package:App_idolconsulting/User/Profile_details.dart';

import 'package:flutter/material.dart';
import 'package:App_idolconsulting/LeaveDays/leavedays.dart';
import 'package:App_idolconsulting/PaySlips/payslips.dart';
import 'package:App_idolconsulting/TravelAllowance/Employee/TravellingAllowance.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:App_idolconsulting/timeSheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../employees_main.dart';
import 'profile.dart';
import 'package:App_idolconsulting/PerformanceAppraisal/performancemain.dart';
import 'userprofile.dart';
import 'homescrean.dart';
import 'package:ionicons/ionicons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerCodeOnly extends StatefulWidget {
  final Widget child;
  DrawerCodeOnly({Key key, this.child}) : super(key: key);

  _DrawerCodeOnlyState createState() => _DrawerCodeOnlyState();
}

class _DrawerCodeOnlyState extends State<DrawerCodeOnly> {
  Map<String, dynamic> data3;
  Map<String, dynamic> users;
  bool isLoading = true;

  Future<String> fetchDrawer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('userToken');

    final response = await http.get(
        'http://app.idolconsulting.co.za/idols/users/profile',
        headers: {"Accept": "application/json", 'X_TOKEN': stringValue});

    if (response.statusCode == 200) {
      setState(() {
        data3 = json.decode(response.body);
      });
    }
  }

  @override
  void initState() {
    this.fetchDrawer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 80,
            margin: EdgeInsets.only(top: 10),
            color: Colors.white,
            child: Image(
              image: AssetImage('images/logo1.png'),
            ),
          ),
          Expanded(
            child: DrawerHeader(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new Profile_details(data3)));
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Center(
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.blue,
                                backgroundImage: NetworkImage(
                                    'http://app.idolconsulting.co.za/idols/file/' +
                                        data3['profilePicture']['id']),
                                //backgroundImage:NetworkImage('http://app.idolconsulting.co.za/idols/file/' + ),
                              ),
                            ),
                            Center(
                              child: Text(
                                data3['firstName'] == null
                                    ? 'no name'
                                    : data3['firstName'] +
                                        '' +
                                        data3['lastName'],
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Center(
                                child: Text(
                              data3['company'] == null
                                  ? 'company found'
                                  : data3['company']['name'],
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                            Center(
                                child: Text(
                              data3['position'] == null
                                  ? 'position not found'
                                  : data3['position']['name'],
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                          ],
                        ),
                      ),
                    ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/background.jpg'),
                      fit: BoxFit.fill)),
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 400,
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Ionicons.home,
                        ),

                        // leading: Container(
                        //   height: 20,
                        //   margin: EdgeInsets.only(top: 10),
                        //   color: Colors.white,
                        //   child: Image(
                        //     image: AssetImage('images/icons/home.PNG'),
                        //   ),
                        // ),
                        //leading: Icon(Ionicons.home, ),

                        title: new Text("Home"),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new Home()));
                        },
                      ),

                      new ListTile(
                        //leading: Icon(Ionicons.briefcase_sharp, size: 30.0),
                        leading: FaIcon(FontAwesomeIcons.home),
                        title: new Text("Companies"),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  // builder: (context) => new list_of_companies()
                                  ));
                        },
                      ),
                      new ListTile(
                        leading: Icon(Ionicons.person_add_outline, size: 30.0),
                        title: new Text("Project"),

//                      new ListTile(
//                        leading: Icon(Ionicons.briefcase_sharp, size: 30.0),
//                        //leading: FaIcon(FontAwesomeIcons.home),
//                        title: new Text("Companies"),
//                        onTap: () {
//                          Navigator.pop(context);
//                          Navigator.push(
//                              context,
//                              new MaterialPageRoute(
//                                // builder: (context) => new Services()
//                              ));
//                        },
                      ),
                      new ListTile(
                        leading: Container(
                          height: 20,
                          margin: EdgeInsets.only(top: 10),
                          color: Colors.white,
                          child: Image(
                            image: AssetImage('images/icons/analytics.PNG'),
                          ),
                        ),
                        //Icon(Icons.timelapse, size: 30.0),
                        title: new Text("Projects"),

                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  //builder: (context) => new Teller()
                                  ));
                        },
                      ),
//                      new ListTile(
//                        leading: Icon(Ionicons.people_outline, size: 30.0),
//                        title: new Text("Employees"),
//                        onTap: () {
//                          Navigator.pop(context);
//                          Navigator.push(
//                              context,
//                              new MaterialPageRoute(
//                                  builder: (context) => new EmployeesHome()
//                              ));
//                        },
//                      ),
                      new ListTile(
                        leading: Icon(Ionicons.people_outline, size: 30.0),
                        title: new Text("Employees"),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new EmployeesHome()));
                        },
                      ),
                      new ListTile(
                        //leading: Icon(Ionicons.calendar, ),
                        leading: FaIcon(FontAwesomeIcons.calendarAlt),

                        // leading: Icon(Ionicons.calendar, ),
                        //  leading: Container(
                        //    height: 20,
                        //    margin: EdgeInsets.only(top: 10),
                        //    color: Colors.white,
                        //    child: Image(image: AssetImage('images/icons/calendar.PNG'),),
                        //  ),
                        //FaIcon(FontAwesomeIcons.calendarAlt),

                        title: new Text("Timesheets"),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new Homepage()));
                        },
                      ),
                      new ListTile(
                        leading: Container(
                          height: 20,
                          margin: EdgeInsets.only(top: 10),
                          color: Colors.white,
                          child: Image(
                            image: AssetImage('images/icons/compose.PNG'),
                          ),
                        ),
                        //Icon(Icons.rate_review, size: 30.0),
                        title: new Text("Leave Days"),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new Leaveday()));
                        },
                      ),
                      new ListTile(
                        leading: Container(
                          height: 20,
                          margin: EdgeInsets.only(top: 10),
                          color: Colors.white,
                          child: Image(
                            image: AssetImage('images/icons/clipboard.PNG'),
                          ),
                        ),
                        //Icon(Icons.assessment, size: 30.0),
                        title: new Text("PaySlips"),
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          String token = prefs.getString('userToken');

                          final response = await http.get(
                              'http://app.idolconsulting.co.za/idols/users/profile',
                              headers: {
                                "Accept": "application/json",
                                'X_TOKEN': '$token'
                              });
                          var data = json.decode((response.body));
                          users = json.decode((response.body));
                          if (response.statusCode == 200) {
                            print("dad");
                            users['id'].toString();
                            print(users['roles'].toString());
                          }
                          print("tttt");
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      users['roles'].toString() == '[Employee]'
                                          ? NewRole()
                                          : MyAppl()));
                        },
                      ),
                      new ListTile(
                        leading: Container(
                          height: 20,
                          margin: EdgeInsets.only(top: 10),
                          color: Colors.white,
                          child: Image(
                            image: AssetImage('images/icons/chatboxes.PNG'),
                          ),
                        ),
                        //Icon(Ionicons.chatbox_outline, size: 30.0),
                        title: new Text("Performance Appraisals"),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new Performance()));
                        },
                      ),
                      new ListTile(
                        leading: Container(
                          height: 20,
                          margin: EdgeInsets.only(top: 10),
                          color: Colors.white,
                          child: Image(
                            image: AssetImage('images/icons/world.PNG'),
                          ),
                        ),
                        //Icon(Ionicons.globe_outline, size: 30.0),
                        title: new Text("Travel Allowances"),
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          String token = prefs.getString('userToken');

                          final response = await http.get(
                              'http://app.idolconsulting.co.za/idols/users/profile',
                              headers: {
                                "Accept": "application/json",
                                'X_TOKEN': '$token'
                              });
                          var data = json.decode((response.body));
                          users = json.decode((response.body));
                          if (response.statusCode == 200) {
                            users['id'].toString();
                            print(users['roles'].toString());
                          }

                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      users['roles'].toString() == '[Employee]'
                                          ? TravelAllowance()
                                          : Admin()));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void setState(fn) {
    isLoading = false;
    super.setState(fn);
  }
}
