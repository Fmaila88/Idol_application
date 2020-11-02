import 'dart:async';
import 'dart:convert';
import 'package:App_idolconsulting/HomePage/drawer.dart';
import 'package:App_idolconsulting/TravelAllowance/Model/Allowance_Model.dart';
import 'package:App_idolconsulting/TravelAllowance/Service/Allowance_Service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'Modify.dart';
import 'Save_Allowance.dart';


class Admin_Allowance extends StatefulWidget {
  @override
  _Admin_AllowanceState createState() => _Admin_AllowanceState();
}

class _Admin_AllowanceState extends State<Admin_Allowance> {

  List<Allowance_Model> allowance = List();
  List<Allowance_Model> filteredAllowance = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Services.getAllowance().then((AllowanceFromServer) {
      setState(() {
        allowance = AllowanceFromServer;
        filteredAllowance = allowance;
      });
    });
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
            children: <Widget>[
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
                        MaterialPageRoute(builder: (context) => Admin_Save()),
                      );
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Create Travel Allowance',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    )),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Card(
                    elevation: 40,
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
                            onChanged: (string) {
                                setState(() {
                                  filteredAllowance = allowance
                                      .where((c) => (c.firstName
                                      .toLowerCase()
                                      .contains(string.toLowerCase())))
                                      .toList();
                                });
                            },
                          ),
                        ),
                        Container(
                          height: 540,
                          child: SizedBox(
                            child: ListView.builder(
                              itemCount: 1,
                              itemBuilder: (BuildContext context, int i) {
                                return Container(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: DataTable(
                                          columnSpacing: 20,
                                          dataRowHeight: 50,
                                          headingRowHeight: 60,
                                          columns: [
                                            DataColumn(
                                              label: Text(
                                                'Name',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w800),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                'Total Km',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w800),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                'Status',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w800),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(
                                                'Travel Date',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w800),
                                              ),
                                            ),
                                            DataColumn(
                                              label: Text(''),
                                            ),
                                          ],
                                          rows: List.generate(
                                              filteredAllowance.length,
                                                  (index) => DataRow(cells: <DataCell>[
                                                DataCell(Text(filteredAllowance[index].firstName + ' ' +
                                                    filteredAllowance[index].lastName),
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => Admin_modify(
                                                        filteredAllowance, index)));
                                                }),
                                                DataCell(Text(filteredAllowance[index].endKm.toString())),
                                                DataCell(Text(filteredAllowance[index].status == null ? 'Pending'
                                                : filteredAllowance[index].status)),
                                                DataCell(Text(filteredAllowance[index].travelDate)),
                                                DataCell(
                                                    Container(
                                                        child: Row(
                                                          children: [
                                                            SizedBox(width: 4),
                                                            FlatButton.icon(
                                                              onPressed: () async {
                                                                final result = await showDialog(
                                                                    context: context, builder: (_) => Approve(
                                                                  filteredAllowance, index
                                                                ));
                                                              },
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
                                                            SizedBox(width: 2),
                                                            FlatButton.icon(
                                                              onPressed: () async {
                                                                  final result = await showDialog(
                                                                  context: context, builder: (_) => Decline(filteredAllowance, index));
                                                              },
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
                                              ])).toList()),
                                    ));
                              },
                            ),
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ));
  }
}


class Decline extends StatefulWidget {
  List list;
  int index;
  Decline(this.list, this.index);
  @override
  _DeclineState createState() => _DeclineState();
}

class _DeclineState extends State<Decline> {

  void confirm() async {
    var url = "https://app.idolconsulting.co.za/idols/travel-allowance";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userToken');
    Map<String, String> headers = {
      "content-type": "application/json",
      "Accept": "application/json",
      "X_TOKEN": "$token",
    };

    final body = jsonEncode({
      'id': widget.list.elementAt(widget.index).id,
      'user': {'firstName': widget.list.elementAt(widget.index).firstName,
                'id': widget.list.elementAt(widget.index).userId,
                'lastName':widget.list.elementAt(widget.index).lastName },
      'status': 'Declined',
      'startKm':  widget.list.elementAt(widget.index).startKm,
      'endKm':  widget.list.elementAt(widget.index).endKm,
      'ratePerKm':  widget.list.elementAt(widget.index).ratePerKm,
      'travelDate':  widget.list.elementAt(widget.index).travelDate,
      'comment':  widget.list.elementAt(widget.index).comment,
    });

    final response = await http.put(url, headers: headers, body: body);

    print(body);
    print(response.body);
    if (response.statusCode == 200) {
      print(json.decode(response.body));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        'Warning!',
        style: TextStyle(color: Colors.red[800]),
      ),
      content: Text(
        'Are you sure you want to decline this allowance?',
        style: TextStyle(
            color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 18),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Yes'),
          onPressed: () {
            confirm();
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Admin_Allowance()));
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

class Approve extends StatefulWidget {

  List list;
  int index;
  Approve(this.list, this.index);

  @override
  _ApproveState createState() => _ApproveState();
}

class _ApproveState extends State<Approve> {

  void confirm() async {
    var url = "https://app.idolconsulting.co.za/idols/travel-allowance";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userToken');
    Map<String, String> headers = {
      "content-type": "application/json",
      "Accept": "application/json",
      "X_TOKEN": "$token",
    };

    final body = jsonEncode({
      'id': widget.list.elementAt(widget.index).id,
      'user': {'id': widget.list.elementAt(widget.index).userId,
        'firstName': widget.list.elementAt(widget.index).firstName,
        'lastName':widget.list.elementAt(widget.index).lastName },
      'status': 'Approved',
      'startKm':  widget.list.elementAt(widget.index).startKm,
      'endKm':  widget.list.elementAt(widget.index).endKm,
      'ratePerKm':  widget.list.elementAt(widget.index).ratePerKm,
      'travelDate':  widget.list.elementAt(widget.index).travelDate,
      'comment':  widget.list.elementAt(widget.index).comment,
    });

    final response = await http.put(url, headers: headers, body: body);

    print(body);
    if (response.statusCode == 200) {
      print(json.decode(response.body));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        'Warning!',
        style: TextStyle(color: Colors.green[500]),
      ),
      content: Text(
        'Are you sure you want to approve this allowance?',
        style: TextStyle(
            color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 18),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Yes'),
          onPressed: () {
            confirm();
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Admin_Allowance()));
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
