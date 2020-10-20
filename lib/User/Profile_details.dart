import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../HomePage/homescrean.dart';


class Profile_details extends StatefulWidget {
  Map<String, dynamic> list;
  Profile_details(this.list);
  @override
  _Profile_detailsState createState() => _Profile_detailsState();
}

class _Profile_detailsState extends State<Profile_details> {

  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  TextEditingController _companyController;
  TextEditingController _positionController;
  TextEditingController _contactController;
  TextEditingController _emailCotroller;
  TextEditingController _passwordController;

  void save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('token');
    Map<String, String> headers = {
      "content-type": "application/json",
      "Accept": "application/json",
      "X_TOKEN": "$stringValue",
    };
    final body = jsonEncode({
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'company' 'name': _companyController.text,
      'position' 'name': _positionController.text,
      'contactNumber': _contactController.text,
      'email': _emailCotroller.text,
      'password': _passwordController.text,
    });
    final response = await http.put(
        'https://app.idolconsulting.co.za/idols/users',
        headers: headers,
        body: body);
    setState(() {
      print(response.body);
      if (response.statusCode == 200) {
        print(jsonDecode(body));
      }
    });
    Navigator.pop(context);
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) =>
            new Home()));
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _firstNameController = new TextEditingController(
        text: "${widget.list['firstName'].toString()}");
    _lastNameController = new TextEditingController(
        text: "${widget.list['lastName'].toString()}");
    _companyController = new TextEditingController(
        text: "${widget.list['company']['name'].toString()}");
    _positionController = new TextEditingController(
        text:
        "${widget.list['position']['name'].toString()}");
    _contactController = new TextEditingController(
        text:
        "${widget.list['contactNumber'].toString()}");
    _emailCotroller = new TextEditingController(
        text:
        "${widget.list['email'].toString()}");
    _passwordController = new TextEditingController(
        text: "${widget.list['password'].toString()}");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Container(
          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
          child: SingleChildScrollView(
            child: Card(
              elevation: 40,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blue,
                      backgroundImage: NetworkImage(
                          'http://app.idolconsulting.co.za/idols/file/' +
                              widget.list['profilePicture']['id']),
                      //backgroundImage:NetworkImage('http://app.idolconsulting.co.za/idols/file/' + ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(70, 0, 40, 5),
                      child: Center(
                        child: FlatButton(
                          color: Colors.blue,
                          child: new Text('Upload Profile Picture',style: new TextStyle(fontSize:17.0,color:Colors.white)),
                          onPressed: (){},
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child: Text(
                      'First Name*',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                    height: 34,
                    child: TextField(
                      readOnly: true,
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child: Text(
                      'Last Name*',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                    height: 34,
                    child: TextField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child: Text(
                      'Company*',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                    height: 34,
                    child: TextField(
                      readOnly: true,
                      controller: _companyController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child: Text(
                      'Employee Position*',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                    height: 34,
                    child: TextField(
                      controller: _positionController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child: Text(
                      'Contact Number*',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                    height: 34,
                    child: TextField(
                      controller: _contactController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child: Text(
                      'Email*',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                    height: 34,
                    child: TextField(
                      controller: _emailCotroller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child: Text(
                      'Password*',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                    height: 34,
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Container(
                        child: RaisedButton(
                          onPressed: () {
                            save();
                          },
                          color: Colors.lightBlue,
                          child: Text('Save',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,),
                          ),
                        ),
                      )
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      '*Complete all required fields',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}


class Profile_data{
  String firstName;
  String lastName;
  String company;
  String position;
  String contact;
  String email;
  String password;

  Profile_data(
      this.firstName,
      this.lastName,
      this.company,
      this.position,
      this.contact,
      this.email,
      this.password
      );
}
















