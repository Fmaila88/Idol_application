import 'package:flutter/material.dart';
import 'login.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App_Idolconsulting',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        accentColor: Colors.white
        //visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginBody(),
    );
  }
}
