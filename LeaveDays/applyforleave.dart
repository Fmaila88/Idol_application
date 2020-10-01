import 'package:flutter/material.dart';
import 'leavedays.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leave dayss',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        //visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Leaveday(),
    );
  }
}

