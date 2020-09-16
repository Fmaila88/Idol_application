import 'dart:convert';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:App_idolconsulting/TravelAllowance/EmployeeData.dart';
import 'package:App_idolconsulting/TravelAllowance/ApplyTransportAllowance.dart';

class TravelAllowance extends StatefulWidget {

  @override
  _TravelAllowanceState createState() => _TravelAllowanceState();
}

class _TravelAllowanceState extends State<TravelAllowance> {

  List<EmployeeData> employee_allowance = new List<EmployeeData>();
  final DateFormat dateformat = DateFormat('MM/YYYY');

  Future<EmployeeData> fetchEmployData() async{

    final response = await http.get ('https://app.idolconsulting.co.za/idols/travel-allowance/all',
        headers: {"Accept": "application/json"});

    if(response.statusCode == 200){
      setState(() {
        var data = json.decode((response.body));
        for(int x = 0; x<data.length; x++){
          var project = new EmployeeData(
            //change name to user when login issue is fixed
              data[x]['name'].toString(),
              data[x]['user'].toString(),
              data[x]['startKm'].toString(),
              data[x]['endKm'].toString(),
              data[x]['travelDate'].toString(),
              data[x]['comment'].toString());
          //print(response.body);
          employee_allowance.add(project);
        }

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
      backgroundColor: Colors.green[50],
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
                    'Apply',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  )),
            ),
           // bodyDate(),
            Container(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Card(
                elevation:2,
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
                        onTap: () {
                          //_selectDate(context);
                        },
                        //keyboardType: TextInputType.multiline,
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 500,
                      child:SizedBox(
                        child:  ListView.builder(
                          itemCount: employee_allowance==null ? 0:employee_allowance.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context,int index) {

                            return Container(
                              child:DataTable(
                                columns: [
                                  DataColumn(label: Text('Name')),
                                  DataColumn(label: Text('Start Km')),
                                  DataColumn(label: Text('End Km')),
                                  DataColumn(label: Text('Travel Date')),
                                  DataColumn(label: Text('')),
                                ],
                                rows: [
                                  DataRow(cells: [
                                    DataCell(Text(employee_allowance.elementAt(index).user)),
                                    DataCell(Text(employee_allowance.elementAt(index).startKm)),
                                    DataCell(Text(employee_allowance.elementAt(index).endKm)),
                                    DataCell(Text((employee_allowance.elementAt(index)
                                        .convertDateFromString()) ??
                                        employee_allowance)),
                                    DataCell(
                                        Container(
                                            child: Row(
                                              children: [
                                                FlatButton.icon(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons.thumb_up,
                                                    size: 15,
                                                    color: Colors.white,
                                                  ),
                                                  color: Colors.green,
                                                  label: Text(
                                                    'Approve',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 17),
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                FlatButton.icon(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons.thumb_down,
                                                    size: 15,
                                                    color: Colors.white,
                                                  ),
                                                  color: Colors.red[500],
                                                  label: Text(
                                                    'Decline',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 17),
                                                  ),
                                                ),
                                              ],
                                            )
                                        )
                                    ),
                                  ])],
                              ),);
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

class Delete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Warning'),
      content: Text('Are you sure you want to delete?'),
      actions: [
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



























