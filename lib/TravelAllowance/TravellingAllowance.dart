import 'dart:convert';

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
      backgroundColor: Colors.white,
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
            Container(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Column(
                children: <Widget> [
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
                ],
              ),
            ),
           // bodyDate(),
            Card(
              elevation:2,
              child: Container(
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
                            DataColumn(
                                label: Text('Name')),
                            DataColumn(label: Text(
                                'Start Km')),
                            DataColumn(label: Text(
                                'End Km')),
                            DataColumn(label: Text(
                                'Travel Date')),
                          ],
                          rows: [
                            DataRow(cells: [
                              DataCell(Text(
                                  employee_allowance.elementAt(index).user
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Apply()),
                                );
                              }),
                              DataCell(Text(
                                  employee_allowance.elementAt(index).startKm
                              ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Apply()),
                                    );
                                  }
                              ),
                              DataCell(Text(
                                  employee_allowance.elementAt(index).endKm
                      ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Apply()),
                                    );
                                  }),
                              DataCell(Text(
                                  employee_allowance.elementAt(index).travelDate),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Apply()),
                                    );
                                  }
                              ),
                            ])],
                        ),);
                    },),
                ),),
            ),
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



























