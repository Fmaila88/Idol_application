import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Apply extends StatefulWidget {
  @override
  _ApplyState createState() => _ApplyState();
}

class _ApplyState extends State<Apply> {

  DateTime _selectedDate;
  TextEditingController _textEditingController = TextEditingController();

  TextEditingController _employeeController = TextEditingController();
  TextEditingController _startKmController = TextEditingController();
  TextEditingController _endKmController = TextEditingController();
  TextEditingController _travelDateController = TextEditingController();
  TextEditingController _commentController = TextEditingController();

  var NamesVariable;
  List<String> myList = [
    'Samuel Komane',
    'Jay Kgatle',
    'Joe Doe',
    'John Smith',
    'Bob Jackson'
  ];

@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
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
      body: Container(
        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        child: SingleChildScrollView(
          child: Card(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                Container(
                  padding: EdgeInsets.fromLTRB(260, 8, 5, 0),
                  child: Text(
                    '*Required fields',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: Text(
                    'Employee:',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12)),
                  margin: const EdgeInsets.all(11),
                  alignment: Alignment.topCenter,

                  child: DropdownButton(
                    hint: Text('Select your Name'),
                    elevation: 5,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 36,
                    isExpanded: true,
                    value: NamesVariable,
                    onChanged: (value) {
                      setState(() {
                        NamesVariable = value;
                      });
                    },
                    items: myList.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: Text(
                    'Start Kilometers*',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                  height: 34,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: Text(
                    'End Kilometers*',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                  height: 34,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: Text(
                    'Rate Per Hour*',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                  height: 34,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: Text(
                    'Travel Date*',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                  height: 34,
                  child: TextField(
                    readOnly: true,
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      //hintText: 'Please select date',
                      border: OutlineInputBorder(),
                    ),
                    onTap: () {
                      _selectDate(context);
                    },
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
                  child: Text(
                    'Comment*',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                  height: 100,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: RaisedButton(
                    color: Colors.lightBlue,
                    onPressed: () async {
                      Map<String, String> headers = {"content-type": "application/json",
                        "Accept": "application/json"};
                      final body = jsonEncode({
                        'user': _employeeController.text,
                        'startKm': _startKmController.text,
                        'endKm': _endKmController.text,
                        'travelDate': _travelDateController.text,
                        'comment': _commentController.text,
                      });
                      final response = await http.put(
                          'https://app.idolconsulting.co.za/idols/travel-allowance',
                          headers: headers,
                          body: body
                      );
                      setState(() {

                        print('dddddddddddddddddd');
                        if(response.statusCode == 200) {
                          print(json.decode(response.body));
                        }
                      });

                      print(json.decode(response.body));
                    },
                    child: Text(
                      'Apply',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  ),
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
        )
      )
    );
  }

  _selectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _textEditingController
        ..text = DateFormat.yMMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textEditingController.text.length,
            affinity: TextAffinity.upstream));
    }
  }
}