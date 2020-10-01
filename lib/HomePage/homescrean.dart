import 'package:App_idolconsulting/LeaveDays/leavedays.dart';
import 'package:App_idolconsulting/PaySlips/DetailsScreen.dart';
import 'package:App_idolconsulting/PaySlips/payslips.dart';
import 'package:App_idolconsulting/TravelAllowance/TravellingAllowance.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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


class Home extends StatefulWidget {
  final Widget child;
  Home({Key key, this.child}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  Map<String, dynamic> data4;
  bool isLoading=true;
  bool load=true;




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


  List<Project> projects = new List<Project>();
  Map<String,dynamic> detail;
  Project project;
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



        //project=Project.fromJson(detail);
        //print(data2.toString());
        // print(response.body);
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
      new Task('Initialized', 0, Colors.pinkAccent),
      new Task('Pending', 98.8, Colors.blue),
      new Task('Complite', 0, Colors.orangeAccent),
    ];

    var pieData1 = [
      new Pollution('Initialized', 98.8, Colors.pinkAccent),
      new Pollution('Pending', 0, Colors.blue),
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

  @override
  void initState() {
    super.initState();
    _seriesData1 = List<charts.Series<Pollution, String>>();
    _seriesPieData = List<charts.Series<Task, String>>();
    _generateData();
    this.fetchProjects();
    // this.fetchTaskings();
    this. fetchTask();
    this.fetchDrawer();
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
                  padding: EdgeInsets.all(8.0),
                ),

//                          DropdownMenuItem(
//                             CircleAvatar(
//                              radius: 30.0,
//                              backgroundImage: ExactAssetImage('images/logo1.png'),
//                            ),
//                         ),
                CustomDropdown(text: "image"),
                //DropdownButton(),
                // Image.asset('images/logo1.png'),

//                          InkWell(
//                            onTap: () => DropdownButton,
//                            child:CircleAvatar(
//                              radius: 30.0,
//                              backgroundImage: ExactAssetImage('images/logo1.png'),
//                            ),
//                          ),

//                          InkWell(
//                              onTap: () => print("image clicked"),
//                            child: CircleAvatar(
//                              backgroundColor: Colors.green,
//                              foregroundColor: Colors.green,
//                              child: Image.asset('images/logo1.png'),
//                            ),
//                          ),

//                              FlatButton(
//                                       child: new Text('Logout',style: new TextStyle(fontSize:17.0,color:Colors.white)),
//                                         onPressed: (){
//                                          //AuthService().signOut();
//                                                    },
//                                                           ),
              ]),
          body:  load ? Center(child: CircularProgressIndicator()):
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
                        child: Container(
                          height: 100,
                          width: 400,
                          child: SizedBox(
                            child:  Container(
                              child: Column(
                                children: <Widget>[
                                  //SizedBox(height: 60.0),
                                  Row(
                                    children: <Widget>[
                                      Text('Name',style: TextStyle(fontSize: 15.0),),
                                      SizedBox(width: 40.0),
                                      Text('End Date',style: TextStyle(fontSize: 15.0),),
                                      SizedBox(width: 40.0),
                                      Text('Status',style: TextStyle(fontSize: 15.0),),
                                      SizedBox(width: 40.0),
                                      Text('Manager',style: TextStyle(fontSize: 15.0),),
                                    ],
                                  ),
                                  SizedBox(height: 30.0),
                                  Row(
                                    children: <Widget>[
                                      Text(detail['name']==null ? 'Project Name not updated' : detail['name']),
                                      SizedBox(width: 5.0),
                                      Text(detail['endDate'].toString()),
                                      SizedBox(width: 5.0 ),
                                      Text(detail['status'].toString()),
                                      SizedBox(width: 40.0),
                                      Text(detail['manager']['firstName'].toString()),//createDate
                                    ],
                                  ),
                                ],
                              ),

//                                child: DataTable(
//                                  columns: [
//                                    DataColumn(label: Text('Name')),
//                                    DataColumn(label: Text('End Date')),
//                                    DataColumn(label: Text('Status')),
//                                    DataColumn(label: Text('Manager')),
//                                  ],
//                                  rows: [
//                                    DataRow(cells: [
//                                      DataCell(Text(detail['name'].toString())),
//                                      DataCell(Text(detail['endDate'].toString())),
//                                      DataCell(Text(detail['status'].toString())),
//                                      DataCell(Text(detail['manager']['status'].toString())),
//                                    ])
////                                    DataRow(cells: [
////                                      DataCell(
////                                          Text(data2['name']==null ? 'No name found ':data2['name'])),
////                                      DataCell(Text(data2['endDate']==null ? 'No date found ':data2['endDate'])),
////                                      DataCell(Text(data2['status']==null ? 'No status found ':data2['status'])),
////                                      DataCell(Text("Andile Zulu"))
////                                    ])
//                                  ],
//                                ),
                            ),
//                            },
//                          ),
                          ),
                        ),
                      ),
                    )
                  ]),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child:
              Container(
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
                      child: load ? Center(child: CircularProgressIndicator()):
                      Card(
                        elevation: 5.0,
                        child:
                        Container(
                          child: SizedBox(
                            child:  Container(
                              //width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      load ? Center(child: CircularProgressIndicator()):
                                      Container(
                                        width: 55.0,
                                        height: 60.0,
                                        color: Colors.white,
                                        child:  load ? Center(child: CircularProgressIndicator()):
                                        CircleAvatar(
                                          radius:50,
                                          backgroundColor: Colors.blue,
                                          backgroundImage:NetworkImage(
                                              'http://app.idolconsulting.co.za/idols/file/' + data4['profilePicture']['id']
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
                            ),
                          ),
                          //   },
                          // ),
                          //  ),
                        ),
                      ),
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
    load=false;
    super.setState(fn);
  }
}

class DrawerCodeOnly extends StatefulWidget {
  final Widget child;
  DrawerCodeOnly({Key key, this.child}) : super(key: key);

  _DrawerCodeOnlyState createState() => _DrawerCodeOnlyState();
}

class _DrawerCodeOnlyState extends State<DrawerCodeOnly> {

  Map<String, dynamic> data3;
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
        data3=json.decode(response.body);

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
      child:Column(
        children: <Widget>[
          Container(
            height: 80,
            margin: EdgeInsets.only(top: 10),
            color: Colors.white,
            child: Image(image: AssetImage('images/logo1.png'),),
          ),
          Expanded(
            child: DrawerHeader(
              child: isLoading ? Center(child: CircularProgressIndicator()):
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, new MaterialPageRoute(builder: (context) => new Profile()));
                },
                child: Container(
                  child: Column(
                    children:[
                      Center(
                        child:CircleAvatar(
                          radius:50,
                          backgroundColor: Colors.blue,
                          backgroundImage:NetworkImage('http://app.idolconsulting.co.za/idols/file/' + data3['profilePicture']['id']),
                        ),
                      ),
                      Center(
                        child: Text(data3['firstName']==null? 'no name' :data3['firstName'] + '' + data3['lastName'],
                          style: TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                      Center(
                          child: Text(data3['company']==null? 'company found' :data3['company']['name'],
                            style: TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold),)
                      ),
                      Center(
                          child: Text(data3['position']==null? 'position not found' : data3['position']['name'],
                            style: TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold),)
                      ) ,
                    ],
                  ),
                ),
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/background.jpg'), fit: BoxFit.fill)
              ),
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
                        leading: Icon(Icons.home, size: 30.0),
                        title: new Text("Home"),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(context,
                              new MaterialPageRoute(builder: (context) => new Home()));
                        },
                      ),
                      new ListTile(
                        leading: Icon(Icons.card_travel, size: 30.0),
                        title: new Text("Companies"),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                // builder: (context) => new Services()
                              ));
                        },
                      ),
                      new ListTile(
                        leading: Icon(Icons.timelapse, size: 30.0),
                        title: new Text("Project"),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                //builder: (context) => new Teller()
                              ));
                        },
                      ),
                      new ListTile(
                        leading: Icon(Icons.group, size: 30.0),
                        title: new Text("Employees"),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                builder: (context) => new EmployeesHome()
                              ));
                        },
                      ),
                      new ListTile(
                        leading: Icon(Icons.calendar_today, size: 30.0),
                        title: new Text("Timesheets"),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new homeScreen()
                              ));
                        },
                      ),
                      new ListTile(
                        leading: Icon(Icons.rate_review, size: 30.0),
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
                        leading: Icon(Icons.assessment, size: 30.0),
                        title: new Text("PaySlips"),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(context,
                              new MaterialPageRoute(builder: (context) => new MyAppl()));
                        },
                      ),
                      new ListTile(
                        leading: Icon(Icons.forum, size: 30.0),
                        title: new Text("Performance"),
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
                        leading: Icon(Icons.card_travel, size: 30.0),
                        title: new Text("Travel Allowance"),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new TravelAllowance()));
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
// enum MenuOption {Logout, Profile}
//
// class DropdownButton extends StatelessWidget {
//  const DropdownButton( {Key key,  Image child}) : super(key: key);
//
//  @override
//   Widget build(BuildContext context){
//    return PopupMenuButton<MenuOption>(
//      itemBuilder: (BuildContext context){
//        return<PopupMenuEntry<MenuOption>>[
//          PopupMenuItem(
//            //child: Text("Logout"),
//            child: Icon(Icons.person,color: Colors.black,size: 28.0,),
//            value: MenuOption.Logout,
//          ),
//          PopupMenuItem(
//            //child: Text("Profile"),
//
//            child: Icon(Icons.exit_to_app,color: Colors.black,size: 28.0,),
//            value: MenuOption.Profile,
//          ),
//
//        ];}
//    );
//  }
// }

class CustomDropdown extends StatefulWidget {
  final String text;

  const CustomDropdown({Key key, @required this.text}) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  GlobalKey actionKey;
  double height, width, xPosition, yPosition;
  bool isDropdownOpened = false;
  OverlayEntry floatingDropdown;

  @override
  void iniState() {
    actionKey = LabeledGlobalKey(widget.text);
    super.initState();
  }

  void findDropdownData() {
    RenderBox renderBox = actionKey.currentContext.findRenderObject();
    // print( RenderBox);
    height = renderBox.size.height;
    width = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    xPosition = offset.dx;
    yPosition = offset.dy;
    print(height);
    print(width);
    print(xPosition);
    print(yPosition);
  }

  OverlayEntry _createFloatingDropdown() {
    return OverlayEntry(builder: (context) {
      return Positioned(
        left: xPosition,
        width: width,
        top: yPosition + height,
        height: 2 * height + 20,
        child: DropDown(
          itemHeight: height,
//        color: Colors.greenAccent,
//        height: 200,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: actionKey,
      onTap: () {
        setState(() {
          if (isDropdownOpened) {
            floatingDropdown.remove();
          } else {
            // print("zzzaa");
            findDropdownData();

            floatingDropdown = _createFloatingDropdown();
            Overlay.of(context).insert(floatingDropdown);
          }
          isDropdownOpened = !isDropdownOpened;
        });
      },
      child: Container(
        color: Colors.grey,
//      decoration: BoxDecoration(
//        borderRadius: BorderRadius.circular(8),
//      ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: <Widget>[
            Text(
              widget.text.toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),

//                          CircleAvatar(
//                              backgroundColor: Colors.green,
//                              foregroundColor: Colors.green,
//                              child: Image.asset('images/logo1.png')
//                            ),

            // Spacer(),
            Icon(Icons.arrow_drop_up),
          ],
        ),
      ),
    );
  }
}

class DropDown extends StatelessWidget {
  final double itemHeight;
  const DropDown({Key key, this.itemHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 5),
        Align(
          alignment: Alignment(-0.85, 0),
          child: ClipPath(
              clipper: ArrowClipper(),
              child: Container(
                height: 20,
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
              )),
        ),
        Material(
          elevation: 20,
          shape: ArrowShape(),
          child: Container(
              height: 2 * itemHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: <Widget>[
                  DropDownItem(
                    text: "Profile",
                    iconDta: Icons.person,
                  ),
                  DropDownItem(
                    text: "Logout",
                    iconDta: Icons.exit_to_app,
                  ),
                ],
              )),
        ),
      ],
    );
  }
}

class DropDownItem extends StatelessWidget {
  final String text;
  final IconData iconDta;
  final bool isSelected;

  const DropDownItem({
    Key key,
    this.text,
    this.iconDta,
    this.isSelected,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
//      decoration: BoxDecoration(
//        borderRadius: BorderRadius.circular(8),
//      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: <Widget>[
          Text(
            text.toUpperCase(),
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
          ),

//                          CircleAvatar(
//                              backgroundColor: Colors.green,
//                              foregroundColor: Colors.green,
//                              child: Image.asset('images/logo1.png')
//                            ),

          // Spacer(),
          Icon(iconDta, color: Colors.white),
        ],
      ),
    );
  }
}

class ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class ArrowShape extends ShapeBorder {
  @override
  // TODO: implement dimensions
  EdgeInsetsGeometry get dimensions => throw UnimplementedError();

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    // TODO: implement getInnerPath
    throw UnimplementedError();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    // TODO: implement getOuterPath
    return getClip(rect.size);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    // TODO: implement paint
  }

  @override
  ShapeBorder scale(double t) {
    // TODO: implement scale
    throw UnimplementedError();
  }

  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);

    return path;
  }
}
