import 'package:App_idolconsulting/PaySlips/payslips.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
//import 'package:payslip_app/payslips.dart';

import '../main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: false);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyAppl(),
  ));
}

class Deede extends StatefulWidget {
  @override
  _DeedeState createState() => _DeedeState();
}

class _DeedeState extends State<Deede> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // drawer: Drawer(),

        );
  }
}
