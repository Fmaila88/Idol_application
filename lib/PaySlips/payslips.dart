import 'package:App_idolconsulting/HomePage/homescrean.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


import 'dart:convert';

//import '../homescrean.dart';
import 'DetailsScreen.dart';
import 'ListEmp.dart';
import 'main.dart';

class MyAppl extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyApplState();
  }
}

class MyApplState extends State<MyAppl> {
  get searchController => null;
  //Future future;
//Future<bool>
  List<ListEmp> employee_Details = new List<ListEmp>();
  String names;

  DateTime now = new DateTime.now();

  final DateFormat dateformat = DateFormat('MM/YYYY');

  Future<ListEmp> fetchListEmp() async {
    final response = await http.get(
        'http://app.idolconsulting.co.za/idols/payslips/all',
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      setState(() {
        var data = json.decode((response.body));
        for (int x = 0; x < data.length; x++) {
          var listEmp = new ListEmp(
              data[x]['firstName'].toString(), data[x]['createDate']);

          employee_Details.add(listEmp);
        }
        print(employee_Details.length);
      });
    }
  }

  // String formatDateTime(DateTime dateTime) {
  //   //return dateformat.DateFormat(dateTime);
  //   return '${dateTime.month}/${dateTime.year}';
  // }

//  void download() async {
//    WidgetsFlutterBinding.ensureInitialized();
//    await FlutterDownloader.initialize(debug: true);
//  }

  @override
  void initState() {
    fetchListEmp();
    super.initState();
  }

  Future<bool> _onBackPressed() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => Home()));

    // return showDialog(
    //     context: context,
    //     builder: (context) => AlertDialog(
    //           title: Text("Do you really want to leave this page"),
    //           actions: <Widget>[
    //             FlatButton(
    //               child: Text("No"),
    //               onPressed: () => Navigator.pop(context, false),
    //             ),
    //             FlatButton(
    //               child: Text("Yes"),
    //               onPressed: () => Navigator.pop(context, true),
    //             ),
    //           ],
    //         ));
  }

  //DateTime now = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      //debugShowCheckedModeBanner: false,
      child: Scaffold(
        backgroundColor: Colors.blueGrey[90],
        // drawer: DrawerCodeOnly(),
        appBar: AppBar(
          title: Text('Payslips'),
          backgroundColor: Colors.blueGrey[300],
        ),
        body: SingleChildScrollView(
            child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(8.0),
                alignment: Alignment.topLeft,
                padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                child: Text(
                  'Pay slips',
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize: 22),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(11.0),
                alignment: Alignment.topLeft,
                padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                child: Text(
                  'Upload, view and download pay slips.',
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                      fontSize: 17),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(11.0),
                alignment: Alignment.topLeft,
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: RaisedButton.icon(
                  onPressed: () {
                    // BuildContext context;
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => DetailsScreen()));
                  },
                  icon: Icon(
                    Icons.cloud_upload,
                    color: Colors.white,
                  ),
                  color: Colors.lightBlue,
                  label: Text(
                    'Upload Payslip',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 17),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 9, 4),
                child: Card(
                  margin: const EdgeInsets.all(0.0),
                  elevation: 6,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                              labelText: 'Search',
                              border: new OutlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: Theme.of(context).primaryColor)),
                              prefixIcon: Icon(Icons.search,
                                  color: Theme.of(context).primaryColor)),
                        ),
                      ),
                      Container(
                        height: 480,
                        //  width: 90,
                        child: SizedBox(
                          child: ListView.builder(
                            itemCount: 1,
                            // employee_Details == null
                            //     ? 0
                            //     : employee_Details.length,
                            scrollDirection: Axis.vertical,

                            shrinkWrap: true,
                            //crossAxisCount: 2,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                child: DataTable(
                                  columnSpacing: 10,
                                  dataRowHeight: 60,
                                  headingRowHeight: 60,
                                  columns: [
                                    DataColumn(
                                        label: Text(
                                      'Date',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 17),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Employee',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 17),
                                    )),
                                    DataColumn(label: Text('')),
                                    DataColumn(label: Text('')),
                                  ],
                                  rows: List.generate(
                                    employee_Details.length,
                                    (index) => DataRow(cells: [
                                      DataCell(Text((employee_Details
                                              .elementAt(index)
                                              .convertDateFromString()) ??
                                          employee_Details)),
                                      DataCell(Text(employee_Details
                                          .elementAt(index)
                                          .user)),
                                      // DataCell(Text(employee_Details
                                      //     .elementAt(index)
                                      //     .lastName)),

                                      DataCell(
                                        FlatButton.icon(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        DetailsScreen()));
                                          },
                                          icon: Icon(
                                            Icons.remove_red_eye,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                          color: Colors.green,
                                          label: Text(
                                            'View',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ),

                                      DataCell(
                                        FlatButton.icon(
//                                          onPressed: (){}, async {
//                                            download();
//                                            final status = await Permission
//                                                .storage
//                                                .request();
//
//                                            if (status.isGranted) {
//                                              final externalDir =
//                                                  await getExternalStorageDirectory();
//
//                                              final id = await FlutterDownloader
//                                                  .enqueue(
//                                                url:
//                                                    "https://app.idolconsulting.co.za/idols/payslips/download/5ba3ac43c391b566c3c51e63",
//                                                savedDir: externalDir.path,
//                                                fileName: "payslip",
//                                                showNotification: true,
//                                                openFileFromNotification: true,
//                                              );
//                                            } else {
//                                              print("Permission denied");
//                                            }
//                                          },

                                          icon: Icon(
                                            Icons.arrow_downward,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                          color: Colors.orange,
                                          label: Text(
                                            'Download',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ]),
                                    // ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
