import 'package:flutter/material.dart';
import 'EmployeeList.dart';
import 'form.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'days.dart';
import 'package:App_idolconsulting/HomePage/homescrean.dart';

class Leaveday extends StatefulWidget {

  @override
  _LeavedayState createState() => _LeavedayState();
}

class _LeavedayState extends State<Leaveday> {

 // Map<String,dynamic> detail;
  var detailList;
  List<Days> detailDays=new List<Days>();
  var days;
  EmployeeList empList;


 // List<Days> days = new List<Days>();

  Future<String> fetchDay() async {
    SharedPreferences prefs =
    await SharedPreferences.getInstance();

    String stringValue = prefs.getString('token');

    final response = await http.get(
      // 'https://app.idolconsulting.co.za/idols/leaves/1/10/ASC/id?keyword=',
        'https://app.idolconsulting.co.za/idols/leaves/all',
        headers: {"Accept": "application/json",
          "X_TOKEN": stringValue,
        });

    if (response.statusCode == 200) {
      setState(() {

        //var data = json.decode((response.body));
       var detailList = json.decode((response.body));


        for (int x = 0; x < detailList.length; x++) {
        var days = new Days(

              detailList[x]['id'],
              detailList[x]['firstName'],
              detailList[x]['start'],
              detailList[x]['end'],
              detailList[x]['days'].toString());

          print(detailList[x]['firstName']);



        detailDays.add(days);
        }




      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       // drawer: DrawerCodeOnly(),
        backgroundColor: Colors.green[50],
        appBar: AppBar(
          title: Text(
            'Leave Days',
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
                  'Apply for leaves',
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
                  'Apply and view days',
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
                        MaterialPageRoute(builder: (context) => Formpage()),
                      );
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Apply for leave',
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
                              itemCount: detailDays==null? 0: detailDays.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context,int index) {

                                return Container(
                                  child:DataTable(
                                    columns: [
                                      DataColumn(label: Text('Employee')),
                                      DataColumn(label: Text('Start Date')),
                                      DataColumn(label: Text('End Date')),
                                      DataColumn(label: Text('Total Days')),
                                    ],
                                    rows: [
                                      DataRow(cells: [
                                        DataCell(Text(detailDays.elementAt(index).employee==null ? 'Employee name not  found' : detailDays.elementAt(index).employee)),
                                       DataCell(Text(detailDays.elementAt(index).startDate==null ? 'Start Date not updated ' : detailDays.elementAt(index).startDate )),
                                        DataCell(Text(detailDays.elementAt(index).end==null? 'End Date not updated' : detailDays.elementAt(index).startDate)),
                                        DataCell(Text(detailDays.elementAt(index).totalDays==null? 'Total days not found' : detailDays.elementAt(index).totalDays))
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
