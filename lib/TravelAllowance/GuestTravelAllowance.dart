import 'dart:convert';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:App_idolconsulting/TravelAllowance/EmployeeData.dart';
import 'package:App_idolconsulting/TravelAllowance/ApplyTransportAllowance.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'package:App_idolconsulting/HomePage/homescrean.dart';

class GuestTravelAllowance extends StatefulWidget {

  @override
  _GuestTravelAllowanceState createState() => _GuestTravelAllowanceState();
}

class _GuestTravelAllowanceState extends State<GuestTravelAllowance> {

  List<EmployeeData> employee_allowance = new List<EmployeeData>();
  final DateFormat dateformat = DateFormat('MM/YYYY');

  Future<EmployeeData> getEmployData() async{

    final response = await http.get ('https://app.idolconsulting.co.za/idols/travel-allowance/all',
        headers: {"Accept": "application/json"});

    if(response.statusCode == 200){
      setState(() {
        var data = json.decode((response.body));
        for(int x = 0; x<data.length; x++){
          var project = new EmployeeData(
              data[x]['user']['firstName'].toString(),
              data[x]['startKm'].toString(),
              data[x]['endKm'].toString(),
              data[x]['travelDate'].toString());
          employee_allowance.add(project);
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getEmployData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green[50],
        drawer: DrawerCodeOnly(),
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
                          height: 550,
                          //width: 500,
                          child:SizedBox(
                            child:  ListView.builder(
                              itemCount: employee_allowance==null ? 0:employee_allowance.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context,int index) {

                                return Container(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: DataTable(
                                          columnSpacing: 40,
                                          dataRowHeight: 60,
                                          headingRowHeight: 50,
                                          columns: [
                                            DataColumn(label: Text('Name',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w800
                                              ),),
                                              numeric: false,
                                            ),
                                            DataColumn(label: Text('Start Km',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w800
                                              ),),
                                              numeric: false,
                                            ),
                                            DataColumn(label: Text('End Km',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w800
                                              ),),
                                              numeric: false,
                                            ),
                                            DataColumn(label: Text('Travel Date',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w800
                                              ),),
                                              numeric: false,
                                            ),
                                          ],
                                          rows: [
                                            DataRow(cells: [
                                              DataCell(Text(employee_allowance.elementAt(index).user)),
                                              DataCell(Text(employee_allowance.elementAt(index).startKm)),
                                              DataCell(Text(employee_allowance.elementAt(index).endKm)),
                                              DataCell(Text((employee_allowance.elementAt(index)
                                                  .convertDateFromString()) ??
                                                  employee_allowance))])].toList(),
                                        ),
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


























