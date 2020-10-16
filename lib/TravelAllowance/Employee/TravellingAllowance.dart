import 'dart:convert';
import 'package:App_idolconsulting/HomePage/drawer.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:App_idolconsulting/TravelAllowance/EmployeeData.dart';
import 'package:App_idolconsulting/TravelAllowance/Employee/ApplyTransportAllowance.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'Edit_TravelAllowance.dart';

class TravelAllowance extends StatefulWidget {

  @override
  _TravelAllowanceState createState() => _TravelAllowanceState();
}

class _TravelAllowanceState extends State<TravelAllowance> {

  List<EmployeeData> employee_allowance = [];
  Map<String,dynamic> list;

  Future<EmployeeData> fetchEmployData() async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    String stringValue = prefs.getString('token');
    print(stringValue);
    //https://app.idolconsulting.co.za/idols/travel-allowance/1/10/DESC/createDate
    final response = await http.get ('https://app.idolconsulting.co.za/idols/travel-allowance/1/10/ASC/CreatedDate',
        headers: {"content-type": "application/json",
          "Accept": "application/json",
          "X_TOKEN":"$stringValue",
        }
          );
    if(response.statusCode == 200){
      setState(() {
        var data = json.decode((response.body));
        list = json.decode((response.body));
        for(int x = 0; x<data.length; x++){
          EmployeeData bodyList = new EmployeeData(
            list['id'].toString(),
            list['startKm'].toString(),
            list['endKm'].toString(),
            list['ratePerKm'].toString(),
            list['status'].toString(),
            list['travelDate'].toString(),
            list['username'].toString(),
            list['comment'],);
          employee_allowance.add(bodyList);
        }
        print(data.length);
        //print('total km ' + list['endkm'] + list['startKm']);
        //print(jsonDecode(response.body));
      });
    }
  }

  List<EmployeeData> projectList = List();
  List<EmployeeData> filteredProject = List();
  EmployeeData userAllownce;
  // FetchProjects fetchUserProjects;

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
                            // onChanged: (text){
                            //   _filterDogList(text);
                            // },

                          ),
                        ),
                        Container(
                          height: 540,
                          child:SizedBox(
                            child: ListView.builder(
                              itemCount: 1,
                              itemBuilder: (BuildContext context,int i) {

                                return Container(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: DataTable (
                                          columnSpacing: 20,
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
                                            DataColumn(label: Text('Total Km',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w800
                                              ),),
                                            ),
                                            DataColumn(label: Text('Status',
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
                                          ],
                                          rows: List.generate(
                                              employee_allowance.length , (index) =>
                                              DataRow(cells: <DataCell> [
                                                DataCell(Text(list['content'][index]['user']['firstName'] + ' ' +
                                                    list['content'][index]['user']['lastName'].toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                  ),),
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => Edit_Allowance(
                                                            list, index
                                                        )),
                                                      );
                                                    }),
                                                DataCell(Text(list['content'][index]['endKm'].toString(),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14
                                                  ),)),
                                                DataCell(Text(list['content'][index]['status'].toString(),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14
                                                  ),)),
                                                DataCell(Text(list['content'][index]['travelDate'].toString(),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14
                                                  ),)),
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