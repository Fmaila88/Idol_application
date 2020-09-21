import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'data.dart';
import 'performanceclass.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Performance Appraisalss',
    home: Performance(),
  ));
}

class Performance extends StatefulWidget {
  @override
  _PerformanceState createState() => _PerformanceState();
}

class _PerformanceState extends State<Performance> {

  List<PerformanceAppraisals> projects = new List<PerformanceAppraisals>();


  Future<String> fetchPerformanceAppraisals() async {
    SharedPreferences prefs =
    await SharedPreferences.getInstance();

    String stringValue = prefs.getString('token');

    final response = await http.get(
        'https://app.idolconsulting.co.za/idols/performanceappraisals/all',

        headers: {"Accept": "application/json",
          "X_TOKEN": "$stringValue",
        });
    List data = json.decode(response.body);

    if (response.statusCode == 200) {
      setState(() {

        var data = json.decode((response.body));
        print(response.body);
        for (int x = 0; x < data.length; x++) {
          var project = new PerformanceAppraisals(
              data[x]['status'],
              data[x]['createdDate'],
              data[x]['firstName']);
          PerformanceAppraisals.add(PerformanceAppraisals);
        }
      });
    }
    print(response.body);

  }
  var tableInfo = TableData();
  int rowPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPerformanceAppraisals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[50],

        appBar: AppBar(
            title: Text("Performance Appraisalssssss"),
            backgroundColor: Colors.blueGrey,
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),

              ),
              DropdownButton(),
            ]),

        body:
        Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 5, 0, 15),
                  child: Text(
                    "Performance Appraisals",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 0, 35),
                  child: Text(
                    "View and give feedback about an Idol Employee.",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                PaginatedDataTable(
                  header: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 14, 10),
                    child: TextField(
                      //readOnly: true,
                      // controller: _endtController,
                      decoration: new InputDecoration(
                        hintText: "search",
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.blueGrey[800],
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueGrey[500])),
                      ),
                      onTap: () {
                        //getEndTime(context);
                      },
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                  columns: [
                    DataColumn(label: Text("Date")),
                    DataColumn(label: Text("Employee")),
                    DataColumn(label: Text("Status")),

                  ],
                  source: tableInfo,
                  onRowsPerPageChanged: (r) {
                    setState(() {
                      rowPerPage = r;
                    });
                  },
                ),
              ],
            ),
          ),
        )
    );

  }



  void _navigateToCreateTimeSheet(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          // builder: (context) => Homepage(),
        ));
  }
}

class Employees {
}

//class TableData extends DataTableSource {
//  @override
//  DataRow getRow(int index) {
//    // TODO: implement getRow
//    return DataRow.byIndex(index: index, cells: [
//      DataCell(Text(PerformanceAppraisals.elementAt(index).id)),
//      DataCell(Text(PerformanceAppraisals.elementAt(index).firstName)),
//      DataCell(Text(PerformanceAppraisals.elementAt(index).status)),
//
//    ]);

class TableData extends DataTableSource {
  @override
  DataRow getRow(int index) {
    // TODO: implement getRow
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text("17/09/20$index")),
      DataCell(Text("Prince$index")),
      DataCell(Text("50%$index")),

    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => true;

  @override
  // TODO: implement rowCount
  int get rowCount => 2;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
enum MenuOption {Logout, Profile}

class DropdownButton extends StatelessWidget {
  const DropdownButton( {Key key,  Image child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuOption>(
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<MenuOption>>[
            PopupMenuItem(
              //child: Text("Logout"),
              child: Icon(Icons.person, color: Colors.black, size: 28.0,),
              value: MenuOption.Logout,
            ),
            PopupMenuItem(
              //child: Text("Profile"),

              child: Icon(Icons.exit_to_app, color: Colors.black, size: 28.0,),
              value: MenuOption.Profile,
            ),

          ];
        }
    );
  }}


