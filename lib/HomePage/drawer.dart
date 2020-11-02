import 'package:App_idolconsulting/TravelAllowance/View/Admin/Travel_Allowance.dart';
import 'package:App_idolconsulting/TravelAllowance/View/Employee/TravellingAllowance.dart';
import 'package:flutter/material.dart';
import 'package:App_idolconsulting/LeaveDays/leavedays.dart';
import 'package:App_idolconsulting/PaySlips/payslips.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:App_idolconsulting/timeSheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:App_idolconsulting/PerformanceAppraisal/performancemain.dart';
import 'homescrean.dart';
import 'package:App_idolconsulting/HomePage/Profile_details.dart';


class DrawerCodeOnly extends StatefulWidget {
  final Widget child;
  DrawerCodeOnly({Key key, this.child}) : super(key: key);

  _DrawerCodeOnlyState createState() => _DrawerCodeOnlyState();
}

class _DrawerCodeOnlyState extends State<DrawerCodeOnly> {

  Map<String, dynamic> data3;
  Map<String,dynamic> users;
  bool isLoading = true;

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
            height: 50,
            margin: EdgeInsets.only(top: 10),
            color: Colors.white,
            child: Image(image: AssetImage('images/logo1.png'),),
          ),
          Expanded(
            child: DrawerHeader(
              child: isLoading ? Center(child: CircularProgressIndicator()) :
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, new MaterialPageRoute
                    (builder: (context) => new Profile_details(data3)));
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
                        child: Text(data3['firstName'] == null
                            ? 'no name'
                            : data3['firstName'] + '' + data3['lastName'],
                          style: TextStyle(fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),),
                      ),
                      Center(
                          child: Text(data3['company'] == null
                              ? 'company found'
                              : data3['company']['name'],
                            style: TextStyle(fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),)
                      ),
                      Center(
                          child: Text(data3['position'] == null
                              ? 'position not found'
                              : data3['position']['name'],
                            style: TextStyle(fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),)
                      ),
                    ],
                  ),
                ),
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/background.jpg'),
                      fit: BoxFit.fill)
              ),
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 300,
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        leading: Container(
                          height: 20,
                          margin: EdgeInsets.only(top: 10),
                          color: Colors.white,
                          child: Image(image: AssetImage('images/icons/home.PNG'),),
                    ),
                        //leading: Icon(Ionicons.home, ),
                        title: new Text("Home"),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(context,
                              new MaterialPageRoute(
                                  builder: (context) => new Home()));
                        },
                      ),

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
//                      ),
                      new ListTile(
                        leading: Container(
                          height: 20,
                          margin: EdgeInsets.only(top: 10),
                          color: Colors.white,
                          child: Image(image: AssetImage('images/icons/analytics.PNG'),),
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
                       // leading: Icon(Ionicons.calendar, ),
                        leading: Container(
                          height: 20,
                          margin: EdgeInsets.only(top: 10),
                          color: Colors.white,
                          child: Image(image: AssetImage('images/icons/calendar.PNG'),),
                        ),
                        //FaIcon(FontAwesomeIcons.calendarAlt),
                        title: new Text("Timesheets"),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new Homepage()
                              ));
                        },
                      ),
                      new ListTile(
                        leading: Container(
                          height: 20,
                          margin: EdgeInsets.only(top: 10),
                          color: Colors.white,
                          child: Image(image: AssetImage('images/icons/compose.PNG'),),
                        ),
                        //Icon(Icons.rate_review, size: 30.0),
                        title: new Text("Leave Days"),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new Leaveday()
                              ));
                        },
                      ),
                      new ListTile(
                        leading: Container(
                          height: 20,
                          margin: EdgeInsets.only(top: 10),
                          color: Colors.white,
                          child: Image(image: AssetImage('images/icons/clipboard.PNG'),),
                        ),
                        //Icon(Icons.assessment, size: 30.0),
                        title: new Text("PaySlips"),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(context,
                              new MaterialPageRoute(
                                  builder: (context) => new MyAppl()));
                        },
                      ),
                      new ListTile(
                        leading: Container(
                          height: 20,
                          margin: EdgeInsets.only(top: 10),
                          color: Colors.white,
                          child: Image(image: AssetImage('images/icons/chatboxes.PNG'),),
                        ),
                        //Icon(Ionicons.chatbox_outline, size: 30.0),
                        title: new Text("Performance Appraisals"),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new Performance()
                              ));
                        },
                      ),
                      new ListTile(
                        leading: Container(
                          height: 20,
                          margin: EdgeInsets.only(top: 10),
                          color: Colors.white,
                          child: Image(image: AssetImage('images/icons/world.PNG'),),
                        ),
                        //Icon(Ionicons.globe_outline, size: 30.0),
                        title: new Text("Travel Allowances"),
                        onTap: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          String token = prefs.getString('userToken');

                          final response = await http.get(
                              'http://app.idolconsulting.co.za/idols/users/profile',
                              headers: {"Accept": "application/json",
                                'X_TOKEN': '$token'});
                          var data = json.decode((response.body));
                          users = json.decode((response.body));
                          if(response.statusCode == 200) {
                            users['id'].toString();
                            print(users['roles'].toString());
                          }

                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => users['roles'].toString() == '[Employee]' ? TravelAllowance()
                              : Admin_Allowance()));
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
    isLoading=false;
    super.setState(fn);
  }
}