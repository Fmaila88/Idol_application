import 'dart:core';

import 'dart:io';
import 'package:date_format/date_format.dart';

import 'package:App_idolconsulting/HomePage/homescrean.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

import 'DetailsScreen.dart';
import 'ListEmp.dart';
import 'View.dart';
import 'ViewUser.dart';

class NewRole extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewRoleState();
  }
}

class NewRoleState extends State<NewRole> {
  convertDateFromString(int index) {
    DateTime todayDate =
        DateTime.parse(list['content'][index]['createDate'].toString());
    return formatDate(todayDate, [MM, ' ', yyyy]);
  }

  List<ListEmp> employee_Details = [];
  Map<String, dynamic> list;
  String names;

  TextEditingController searchController = new TextEditingController();

  DateTime now = new DateTime.now();

  final DateFormat dateformat = DateFormat('MM/YYYY');

  Future<ListEmp> fetchListEmp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('token');
    print(stringValue);
    //'https://app.idolconsulting.co.za/idols/payslips/1/10/ASC/CreatedDate'
    //https: //app.idolconsulting.co.za/idols/payslips/1/10/ASC/10?keyword=createDate
    final response = await http.get(
        'https://app.idolconsulting.co.za/idols/payslips/1/10/ASC/ASC',
        headers: {
          "content-type": "application/json",
          "Accept": "application/json",
          "X_TOKEN": "$stringValue",
          HttpHeaders.authorizationHeader: "$stringValue",
        });

    // if (response.statusCode == 200) {
    //   setState(() {
    //     var data = json.decode((response.body));
    //     print(data.length);
    //     // print(response.body);
    //
    //     for (int x = 0; x < data.length; x++) {
    //       if (data[x]['user'] != null) {
    //         var listEmp = new ListEmp(
    //             data[x]['user']['firstName'] +
    //                 ' ' +
    //                 data[x]['user']['lastName'].toString(),
    //             data[x]['createDate']);
    //
    //         employee_Details.add(listEmp);
    //       }
    //     }
    //     print(employee_Details.length);
    //     // print(employee_Details.toString());
    //   });
    // }

    if (response.statusCode == 200) {
      setState(() {
        var data = json.decode((response.body));
        list = json.decode((response.body));
        //if (list['user'] != null) {
        for (int x = 0; x < data.length; x++) {
          ListEmp bodyList = new ListEmp(list['id'].toString(),
              list['user'].toString(), list['createDate']);
          employee_Details.add(bodyList);
        }
        // }
        print(employee_Details.length);
        print(data.length);
      });
    }
  }

  void deletePyslip() async {
    var url = "https://app.idolconsulting.co.za/idols/payslips/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('userToken');
    Map<String, String> headers = {
      "content-type": "application/json",
      "Accept": "application/json",
      "X_TOKEN": "$stringValue",
    };
    // http.delete(
    //   url + "/${[index]['id']}",
    //   headers: headers,
    // );
  }

  @override
  void initState() {
    super.initState();
    this.fetchListEmp();
  }

  Future<bool> _onBackPressed() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => Home()));
  }

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
                padding: EdgeInsets.fromLTRB(6, 7, 0, 5),
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
                  'View and download pay slips.',
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                      fontSize: 17),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 9, 4),
                child: Card(
                  margin: const EdgeInsets.all(0.0),
                  elevation: 3,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                              labelText: 'Search by date',
                              border: new OutlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: Theme.of(context).primaryColor)),
                              prefixIcon: Icon(Icons.search,
                                  color: Theme.of(context).primaryColor)),
                        ),
                      ),
                      Container(
                        height: 300,
                        //  width: 90,
                        child: SizedBox(
                          child: ListView.builder(
                            itemCount: 1,

                            // scrollDirection: Axis.vertical,
                            // shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    columnSpacing: 10,
                                    dataRowHeight: 60,
                                    headingRowHeight: 50,
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
                                      // DataColumn(label: Text('')),
                                    ],
                                    rows: List.generate(
                                      employee_Details.length,
                                      (index) => DataRow(cells: [
                                        DataCell(
                                            Text(
                                              convertDateFromString(index),
                                            ), onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailsScreen()),
                                          );
                                        }),
                                        DataCell(
                                          Text(
                                            list['content'][index]['user']
                                                    ['firstName'] +
                                                ' ' +
                                                list['content'][index]['user']
                                                        ['lastName']
                                                    .toString(),
                                          ),
                                        ),
                                        DataCell(
                                          FlatButton.icon(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) => ViewUser(
                                                          list, index)));
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
                                            onPressed: () async {
                                              //var url = "https://app.idolconsulting.co.za/idols/payslips";
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              String stringValue =
                                                  prefs.getString('userToken');
                                              Map<String, String> headers = {
                                                "content-type":
                                                    "application/json",
                                                "Accept": "application/json",
                                                "X_TOKEN": "$stringValue",
                                              };

                                              final status = await Permission
                                                  .storage
                                                  .request();

                                              if (status.isGranted) {
                                                final externalDir =
                                                    await getExternalStorageDirectory();

                                                String PayslipId =
                                                    list['content'][index]
                                                        ['id'];
                                                print(PayslipId);

                                                final id =
                                                    await FlutterDownloader
                                                        .enqueue(
                                                  url:
                                                      "https://app.idolconsulting.co.za/idols/payslips/download/" +
                                                          '$PayslipId',
                                                  savedDir: externalDir.path,
                                                  fileName: "payslip.pdf",
                                                  headers: headers,
                                                  showNotification: true,
                                                  openFileFromNotification:
                                                      true,
                                                );
                                              } else {
                                                print("Permission denied");
                                              }
                                            },
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
                                        // DataCell(
                                        //   FlatButton.icon(
                                        //     onPressed: () {
                                        //       _delete();
                                        //     },
                                        //     icon: Icon(
                                        //       Icons.delete,
                                        //       size: 15,
                                        //       color: Colors.white,
                                        //     ),
                                        //     color: Colors.redAccent,
                                        //     label: Text(
                                        //       'Delete',
                                        //       style: TextStyle(
                                        //           color: Colors.white,
                                        //           fontWeight: FontWeight.w400,
                                        //           fontSize: 14),
                                        //     ),
                                        //   ),
                                        // ),
                                      ]),
                                      // ],
                                    ),
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

  // Future<bool> _delete() {
  //   return showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //             title: Text("Do you really want to delete this payslip"),
  //             actions: <Widget>[
  //               FlatButton(
  //                 child: Text(
  //                   "No",
  //                   style: new TextStyle(color: Colors.green),
  //                 ),
  //                 onPressed: () => Navigator.pop(context, false),
  //               ),
  //               FlatButton(
  //                   child: Text(
  //                     "Yes",
  //                     style: new TextStyle(color: Colors.redAccent),
  //                   ),
  //                   onPressed: () {
  //                     Navigator.pop(context, true);
  //                     deletePyslip();
  //                   }),
  //             ],
  //           ));
  // }
}
