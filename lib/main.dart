import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'login.dart';
//import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: false);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your apication.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App_Idolconsulting',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        //visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginBody(),
    );
  }
}
