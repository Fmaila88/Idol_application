import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:App_idolconsulting/TravelAllowance/EmployeeData.dart';
import 'package:App_idolconsulting/TravelAllowance/ApplyTransportAllowance.dart';

import '../homescrean.dart';

class TravelAllowance extends StatefulWidget {

  @override
  _TravelAllowanceState createState() => _TravelAllowanceState();
}

class _TravelAllowanceState extends State<TravelAllowance> {

  List<EmployeeData> employee_allowance = new List<EmployeeData>();
  final DateFormat dateformat = DateFormat('MM/YYYY');
  String token;

  Future<EmployeeData> fetchEmployData() async{
    final response = await http.get ('https://app.idolconsulting.co.za/idols/travel-allowance/all',
        headers: {"Accept": "application/json"});
    if(response.statusCode == 200){
      setState(() {
        var data = json.decode((response.body));
        for(int x = 0; x<data.length; x++){
          var bodyList = new EmployeeData(
              data[x]['user']['firstName'].toString(),
              data[x]['startKm'].toString(),
              data[x]['endKm'].toString(),
              data[x]['travelDate'].toString());
          employee_allowance.add(bodyList);
          // final Iterable list = data[x]['user']['firstName'];
          // var totalEmployees = list.map((model) => EmployeeData.fromJson(model)).toList();
        }
        print(data.length);
        //print(jsonDecode(response.body));
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchEmployData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightGreen[10],
        //drawer: DrawerCodeOnly(),
        appBar: AppBar(
          title: Text(
            'Travel Allowance',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blueGrey[400],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              Container(
                padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
                child: Text(
                  'Travel Allowances',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    //
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(
                  'Apply for travel allowances',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                child: RaisedButton.icon(
                    color: Colors.lightBlue,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Apply()),
                      );
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Create',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    )),
              ),
              // bodyDate(),
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Card(
                    elevation:40,
                    child: Column(
                      children: [
                        Container(
                          height: 54,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search',
                              prefixIcon: Icon(
                                Icons.search,
                              ),
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (text) {
                              text = text.toLowerCase();
                              setState(() {
                                employee_allowance = employee_allowance.where((text) {
                                  return employee_allowance.contains(text);
                                }).toList();
                              });
                            },

                          ),
                        ),
                        Container(
                          height: 550,
                          child:SizedBox(
                            child:  ListView.builder(
                              itemCount: 1,
                              itemBuilder: (BuildContext context,int index) {

                                return Container(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: DataTable (
                                        columnSpacing: 25,
                                        dataRowHeight: 50,
                                        headingRowHeight: 60,
                                        columns: [
                                          DataColumn(label: Text('Name',
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800
                                            ),),
                                          ),
                                          DataColumn(label: Text('Start Km',
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800
                                            ),),
                                          ),
                                          DataColumn(label: Text('End Km',
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800
                                            ),),
                                          ),
                                          DataColumn(label: Text('Travel Date',
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800
                                            ),),
                                          ),
                                          // DataColumn(label: Text(''),
                                          //   numeric: false,
                                          // ),
                                        ],
                                        rows: List.generate(
                                            employee_allowance.length, (index) =>
                                          DataRow(cells: <DataCell> [
                                            DataCell(Text(employee_allowance.elementAt(index).user)),
                                            DataCell(Text(employee_allowance.elementAt(index).startKm)),
                                            DataCell(Text(employee_allowance.elementAt(index).endKm)),
                                            DataCell(Text((employee_allowance.elementAt(index)
                                                .convertDateFromString()) ??
                                                employee_allowance)),
                                            // DataCell(
                                            //     Container(
                                            //         child: Row(
                                            //           children: [
                                            //             FlatButton.icon(
                                            //               onPressed: () async {
                                            //                 // final result = await showDialog(
                                            //                 //     context: context, builder: (_) => Approve());
                                            //               },
                                            //               icon: Icon(
                                            //                 Icons.arrow_downward,
                                            //                 size: 15,
                                            //                 color: Colors.white,
                                            //               ),
                                            //               color: Colors.orange,
                                            //               label: Text(
                                            //                 'Download',
                                            //                 style: TextStyle(
                                            //                     color: Colors.white,
                                            //                     fontWeight: FontWeight.w400,
                                            //                     fontSize: 17),
                                            //               ),
                                            //             ),
                                            //             SizedBox(width: 2),
                                            //             FlatButton.icon(
                                            //               onPressed: () async {
                                            //                 final result = await showDialog(
                                            //                     context: context, builder: (_) => Approve());
                                            //               },
                                            //               icon: Icon(
                                            //                 Icons.thumb_up,
                                            //                 size: 15,
                                            //                 color: Colors.white,
                                            //               ),
                                            //               color: Colors.green,
                                            //               label: Text(
                                            //                 'Approve',
                                            //                 style: TextStyle(
                                            //                     color: Colors.white,
                                            //                     fontWeight: FontWeight.w400,
                                            //                     fontSize: 17),
                                            //               ),
                                            //             ),
                                            //             SizedBox(width: 2),
                                            //             FlatButton.icon(
                                            //               onPressed: () async {
                                            //                 final result = await showDialog(
                                            //                     context: context, builder: (_) => Decline());
                                            //               },
                                            //               icon: Icon(
                                            //                 Icons.thumb_down,
                                            //                 size: 15,
                                            //                 color: Colors.white,
                                            //               ),
                                            //               color: Colors.red[500],
                                            //               label: Text(
                                            //                 'Decline',
                                            //                 style: TextStyle(
                                            //                     color: Colors.white,
                                            //                     fontWeight: FontWeight.w400,
                                            //                     fontSize: 17),
                                            //               ),
                                            //             ),
                                            //           ],
                                            //         )
                                            //     )
                                            // ),
                                          ])).toList()
                                      ),
                                    )
                                );
                              },),
                          ),),
                      ],
                    )
                ),
              )
            ],
          ),
        )
    );
  }
}

class Decline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('Warning!',
        style: TextStyle(
            color: Colors.red[800]
        ),),
      content: Text('Are you sure you want to decline this allowance?',
        style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w400,
            fontSize: 18
        ),),
      actions: <Widget>[
        FlatButton(
          child: Text('Yes'),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        FlatButton(
          child: Text('No'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ],
    );
  }
}

class Approve extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('Warning!',
        style: TextStyle(
            color: Colors.green[500]
        ),),
      content: Text('Are you sure you want to approve this allowance?',
        style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w400,
            fontSize: 18
        ),),
      actions: <Widget>[
        FlatButton(
          child: Text('Yes'),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        FlatButton(
          child: Text('No'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ],
    );
  }
}