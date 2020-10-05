import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Logout extends StatefulWidget {
  final Widget child;
  Logout({Key key, this.child}) : super(key: key);

  _LogoutState createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {

  Map<String, dynamic> log;
  bool isLoading=true;

  Future<String> fetchLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('userToken');

    final response = await http.get(
        'https://app.idolconsulting.co.za/idols/users/logout',
        headers: {"Accept": "application/json",
          'X_TOKEN': stringValue});

    if(response.statusCode ==200){
      setState((){
        log=json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}