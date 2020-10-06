import 'package:App_idolconsulting/employees_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'edit_data.dart';

class Detail extends StatefulWidget {
  final List list;
  final int index;
  Detail({this.list, this.index});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  void deleteData() async {
    var url = "https://app.idolconsulting.co.za/idols/users";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('userToken');
    Map<String, String> headers = {
      "content-type": "application/json",
      "Accept": "application/json",
      "X_TOKEN": "$stringValue",
    };
    http.delete(
      url + "/${widget.list[widget.index]['id']}",
      headers: headers,
    );
  }

  void confirm() {
    //do something
    AlertDialog alertDialog = new AlertDialog(
      content: new Text(
          "Are your sure you want to Delete ${widget.list[widget.index]['firstName']}"),
      actions: [
        new RaisedButton(
          child: new Text(
            "OK DELETE!",
            style: new TextStyle(color: Colors.black),
          ),
          color: Colors.redAccent,
          onPressed: () {
            deleteData();
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new EmployeesHome()));
          },
        ),
        new RaisedButton(
            child:
                new Text("CANCEL", style: new TextStyle(color: Colors.black)),
            color: Colors.redAccent,
            onPressed: () => Navigator.pop(context)),
      ],
    );
    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${widget.list[widget.index]["firstName"] + " " + widget.list[widget.index]["lastName"]}"),
      ),
      body: SingleChildScrollView(
        child: new Container(
          padding: EdgeInsets.all(10.0),
          child: new Card(
            child: Center(
              child: Column(
                children: [
                  // new Text(
                  //   "Emp id. : ${widget.list[widget.index]['id']}",
                  //   style: TextStyle(fontSize: 20.0),
                  // ),
                  // SizedBox(height: 5.0),
                  new Text(
                    "Emp number. : ${widget.list[widget.index]['employeeNumber']}",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(height: 5.0),
                  new Text(
                    "First Name: ${widget.list[widget.index]['firstName']}",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(height: 5.0),
                  new Text(
                    "Last Name: ${widget.list[widget.index]['lastName']}",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(height: 5.0),
                  new Text(
                    "Company: ${widget.list[widget.index]['company']['name']}",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(height: 5.0),
                  new Text(
                    "Position: ${widget.list[widget.index]['position']['name']}",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  new Text(
                    "Role: ${widget.list[widget.index]['roles'][0]}",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  new Text(
                    "Ann Leave Days: ${widget.list[widget.index]['annualLeaveDays']}",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  new Text(
                    "Sick Leave Days: ${widget.list[widget.index]['sickLeaveDays']}",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  new Text(
                    "Fam Responsibility: ${widget.list[widget.index]['familyResponsibility']}",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  new Text(
                    "contactNumber: ${widget.list[widget.index]['contactNumber']}",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  new Text(
                    "Email: ${widget.list[widget.index]['email']}",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  new Text(
                    "password: ${widget.list[widget.index]['password']}",
                    style: TextStyle(fontSize: 20.0),
                  ),

                  new Padding(padding: EdgeInsets.only(top: 30.0)),

                  new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      new RaisedButton(
                        child: Text("EDIT"),
                        color: Colors.lightGreen,
                        onPressed: () => Navigator.of(context).push(
                          new MaterialPageRoute(
                            builder: (BuildContext context) => new EditData(
                              list: widget.list,
                              index: widget.index,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20.0),
                      new RaisedButton(
                        child: Text("DELETE"),
                        color: Colors.redAccent,
                        onPressed: () => confirm(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
