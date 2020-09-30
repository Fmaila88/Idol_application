import 'package:App_idolconsulting/employees/screens/add_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'employees/screens/details.dart';

void main() {
  runApp(new MaterialApp(
    title: "Employees",
    home: new EmployeesHome(),
  ));
}

class EmployeesHome extends StatefulWidget {
  @override
  _EmployeesHomeState createState() => _EmployeesHomeState();
}

class _EmployeesHomeState extends State<EmployeesHome> {
  Future<List> getData() async {
    final response =
        await http.get("https://app.idolconsulting.co.za/idols/users/all");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("Employees"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  child: Text(
                    'Employees',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  child: Text(
                    'Add, Edit and View employees that are registered with Idol.',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  onPressed: () =>
                      Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new AddData(),
                  )),
                  color: Colors.blue,
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_add,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'Add Employees',
                        style: TextStyle(fontSize: 12.0, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  onPressed: () {},
                  color: Colors.blue,
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_add,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'Positions',
                        style: TextStyle(fontSize: 12.0, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Flexible(
              child: new FutureBuilder<List>(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData
                      ? new ItemList(list: snapshot.data)
                      : new Center(
                          child: new CircularProgressIndicator(),
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new ListTile(
          title: new Container(
            //padding: const EdgeInsets.only(top: 5.0),
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new Detail(list: list, index: i),
                ),
              ),
              child: new Card(
                child: new ListTile(
                  title: new Row(
                    children: [
                      Text(list[i]['firstName']),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(list[i]['lastName']),
                    ],
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Colors.black26,
                    radius: 25.0,
                    child: Text(list[i]['firstName'][0]),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
