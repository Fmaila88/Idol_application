import 'dart:core';
import 'dart:io';
import 'package:App_idolconsulting/HomePage/homescrean.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:date_format/date_format.dart';
import 'dart:convert';

import 'ListPro.dart';
import 'TaskProject.dart';

class Projected extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProjectedState();
  }
}

class ProjectedState extends State<Projected> {
  // convertDateFromString(int index) {
  //   DateTime todayDate = DateTime.parse(this.createDate);
  //   return formatDate(todayDate, [MM, ' ', yyyy]);
  // }

  // DateTime now = new DateTime.now();

  // final DateFormat dateformat = DateFormat('MM/YYYY');
  //
  // convertDateString(int index) {
  //   DateTime todayDate =
  //       DateTime.parse(list['content'][index]['endDate'].toString());
  //   return formatDate(todayDate, [MM, ' ', yyyy]);
  // }

  // List<ListPro> Project_Details = [];
  List<ListPro> Project_Details = new List<ListPro>();
  // Map<String, dynamic> list;
  String names;

  TextEditingController searchController = new TextEditingController();

  Future<ListPro> fetchListPro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('token');
    print(stringValue);
    final response = await http
        .get('https://app.idolconsulting.co.za/idols/projects/all', headers: {
      "content-type": "application/json",
      "Accept": "application/json",
      "X_TOKEN": "$stringValue",
      HttpHeaders.authorizationHeader: "$stringValue",
    });

    if (response.statusCode == 200) {
      setState(() {
        var data = json.decode((response.body));
        // list = json.decode((response.body));
        for (int x = 0; x < data.length; x++) {
          ListPro bodyList = new ListPro(
            data[x]['id'].toString(),
            data[x]['createDate'],
            data[x]['name'].toString(),
            data[x]['endDate'].toString(),
            data[x]['budget'].toString(),
            data[x]['status'].toString(),
            data[x]['manager']['firstName'].toString() +
                " " +
                data[x]['manager']['lastName'].toString(),
          );
          Project_Details.add(bodyList);
        }
        // }
        print(Project_Details.length);
        print(data.length);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this.fetchListPro();
  }

  Future<bool> _onBackPressed() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => Home()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.blueGrey[90],
        appBar: AppBar(
          title: Text('Projects'),
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
                  'Projects',
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
                  'Create, view, track and approve projects.',
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
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => TaskProject()));
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  color: Colors.lightBlue,
                  label: Text(
                    'Add Project',
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
                        height: 500,
                        //  width: 90,
                        child: SizedBox(
                          child: ListView.builder(
                            itemCount: 1,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    columnSpacing: 10,
                                    dataRowHeight: 60,
                                    headingRowHeight: 60,
                                    columns: [
                                      DataColumn(
                                          label: Text(
                                        'Create Date',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 17),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Name',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 17),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'End Date',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 17),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Budget',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 17),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Status',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 17),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'Manager',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 17),
                                      )),
                                      DataColumn(label: Text('')),
                                    ],
                                    rows: List.generate(
                                      Project_Details.length,
                                      (index) => DataRow(cells: [
                                        DataCell(
                                            Text((Project_Details.elementAt(
                                                        index)
                                                    .convertDateFromString()) ??
                                                Project_Details), onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TaskProject()),
                                          );
                                        }),
                                        DataCell(
                                          Text(Project_Details.elementAt(index)
                                              .name),
                                        ),
                                        DataCell(
                                          Text(Project_Details.elementAt(index)
                                              .endDate),
                                        ),
                                        DataCell(
                                          Text(Project_Details.elementAt(index)
                                              .budget),
                                        ),
                                        DataCell(
                                          Text(Project_Details.elementAt(index)
                                              .status),
                                        ),
                                        DataCell(
                                          Text(Project_Details.elementAt(index)
                                              .manager),
                                        ),
                                        DataCell(
                                          Text(
                                            '',
                                          ),
                                        ),
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

  Future<bool> _delete() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Do you really want to delete this payslip"),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    "No",
                    style: new TextStyle(color: Colors.green),
                  ),
                  onPressed: () => Navigator.pop(context, false),
                ),
                FlatButton(
                    child: Text(
                      "Yes",
                      style: new TextStyle(color: Colors.redAccent),
                    ),
                    onPressed: () {
                      Navigator.pop(context, true);
                      // deletePyslip();
                    }),
              ],
            ));
  }
}
