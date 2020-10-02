import 'dart:convert';

import 'package:App_idolconsulting/PaySlips/payslips.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Employees.dart';

class DetailsScreen extends StatefulWidget {
  @override
  _DetailsScreenState createState() => new _DetailsScreenState();
}

String title = 'DropDownButton';

class _DetailsScreenState extends State<DetailsScreen> {
  DateTime datePicker;
  TextEditingController _textEditingController = TextEditingController();

  _selectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
      context: context,
      initialDate: datePicker != null ? datePicker : DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2040),
    );

    if (newSelectedDate != null) {
      datePicker = newSelectedDate;
      _textEditingController
        ..text = DateFormat.yMMMMd().format(datePicker)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textEditingController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  List<Employees> _employeeName = new List<Employees>();
  String names;

  TextEditingController _employeeController = TextEditingController();

  TextEditingController _paymentDateController = TextEditingController();
  TextEditingController _hourlyRateController = TextEditingController();
  TextEditingController _monthlyHoursController = TextEditingController();
  TextEditingController _overtimeHoursController = TextEditingController();
  TextEditingController _overtimeRateController = TextEditingController();
  TextEditingController _taxNumberController = TextEditingController();
  TextEditingController _bonusController = TextEditingController();

  Future<Employees> fetchEmployees() async {
    final response = await http.get(
        'http://app.idolconsulting.co.za/idols/users/all',
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      setState(() {
        var data = json.decode((response.body));
        for (int x = 0; x < data.length; x++) {
          var employees = new Employees(
              data[x]['firstName'].toString(), data[x]['lastName'].toString());

          _employeeName.add(employees);
        }
      });
    }
  }

  @override
  void initState() {
    fetchEmployees();
    //savePay();
    super.initState();
    _hourlyRateController.text = "0";
    _monthlyHoursController.text = "0";
    _overtimeHoursController.text = "0";
    _overtimeRateController.text = "0";
  }

  Future<bool> _onBackPressed() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => MyAppl()));
    // return showDialog(
    //     context: context,
    //     builder: (context) => AlertDialog(
    //           //  title: Text("Press Yes to go to the first page"),
    //           actions: <Widget>[
    //             // FlatButton(
    //             //   child: Text("No"),
    //             //   onPressed: () => Navigator.pop(context, false),
    //             // ),
    //             FlatButton(
    //               // child: Text("Yes"),
    //               onPressed: () => Navigator.pop(context, true),
    //             ),
    //           ],
    //         ));
  }

  var items;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Payslip Details'),
          backgroundColor: Colors.blueGrey[300],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Card(
                  elevation: 4,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(11.0),
                        alignment: Alignment.topRight,
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          '* Required fields',
                          style: TextStyle(
                              color: Colors.black26,
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                      ),

                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                        child: Text(
                          'Payment Date*',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(3, 0, 10, 0),
                        height: 48,
                        child: TextField(
                          readOnly: true,
                          controller: _textEditingController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0.0))),
                            //  margin: EdgeInsets.fromLTRB(3, 5, 10, 5),
                          ),
                          onTap: () {
                            _selectDate(context);
                          },
                          keyboardType: TextInputType.multiline,
                        ),
                      ),

                      Container(
                        // margin: const EdgeInsets.all(11.0),
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.fromLTRB(10, 17, 10, 2),
                        child: Text(
                          'Employee Name*',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        //margin: const EdgeInsets.all(16.0),
                        // padding: const EdgeInsets.only(left: 16.0, right: 16.0)
                        padding: EdgeInsets.only(left: 16.0, right: 16.0),
                        // padding: const EdgeInsets.fromLTRB(130, 0, 0, 0),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black54, width: 0.5)),

                        margin: EdgeInsets.fromLTRB(3, 5, 10, 5),

                        alignment: Alignment.topLeft,

                        child: DropdownButton<Employees>(
                          underline: SizedBox(),
                          //hint: Text('Employee Name'),
                          // elevation: 5,

                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 30.0,
                          isExpanded: true,
                          items: _employeeName.map((Employees names) {
                            return DropdownMenuItem<Employees>(
                              value: names,
                              child: Text("$names"),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              this.items = value;
                            });
                          },
                          value: items,
                        ),
                      ),
                      Container(
                        // margin: const EdgeInsets.all(11.0),
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.fromLTRB(10, 13, 10, 4),
                        child: Text(
                          'Hourly Rate*',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                // contentPadding: EdgeInsets.fromLTRB(15, 5, 10, 5),
                                contentPadding: EdgeInsets.all(8.0),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0.0))),
                              ),
                              controller: _hourlyRateController,
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: false,
                                signed: true,
                              ),
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                          Container(
                            height: 38.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 0.0,
                                      ),
                                    ),
                                  ),
                                  child: InkWell(
                                    child: Icon(
                                      Icons.arrow_drop_up,
                                      size: 18.0,
                                    ),
                                    onTap: () {
                                      int currentValue =
                                          int.parse(_hourlyRateController.text);
                                      setState(() {
                                        currentValue++;
                                        _hourlyRateController.text =
                                            (currentValue)
                                                .toString(); // incrementing value
                                      });
                                    },
                                  ),
                                ),
                                InkWell(
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    size: 20.0,
                                  ),
                                  onTap: () {
                                    int currentValue =
                                        int.parse(_hourlyRateController.text);
                                    setState(() {
                                      print("Setting state");
                                      currentValue--;
                                      _hourlyRateController.text =
                                          (currentValue > 0 ? currentValue : 0)
                                              .toString(); // decrementing value
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Container(
                        // margin: const EdgeInsets.all(11.0),
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.fromLTRB(10, 18, 10, 4),
                        child: Text(
                          'Monthly Hours*',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                // contentPadding: EdgeInsets.fromLTRB(15, 5, 10, 5),
                                contentPadding: EdgeInsets.all(8.0),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0.0))),
                              ),
                              controller: _monthlyHoursController,
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: false,
                                signed: true,
                              ),
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                          Container(
                            height: 38.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 0.0,
                                      ),
                                    ),
                                  ),
                                  child: InkWell(
                                    child: Icon(
                                      Icons.arrow_drop_up,
                                      size: 18.0,
                                    ),
                                    onTap: () {
                                      int currentValue = int.parse(
                                          _monthlyHoursController.text);
                                      setState(() {
                                        currentValue++;
                                        _monthlyHoursController.text =
                                            (currentValue)
                                                .toString(); // incrementing value
                                      });
                                    },
                                  ),
                                ),
                                InkWell(
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    size: 20.0,
                                  ),
                                  onTap: () {
                                    int currentValue =
                                        int.parse(_monthlyHoursController.text);
                                    setState(() {
                                      print("Setting state");
                                      currentValue--;
                                      _monthlyHoursController.text =
                                          (currentValue > 0 ? currentValue : 0)
                                              .toString(); // decrementing value
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Container(
                        // margin: const EdgeInsets.all(11.0),
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.fromLTRB(10, 18, 10, 4),
                        child: Text(
                          'Overtime Hours*',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                // contentPadding: EdgeInsets.fromLTRB(15, 5, 10, 5),
                                contentPadding: EdgeInsets.all(8.0),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0.0))),
                              ),
                              controller: _overtimeHoursController,
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: false,
                                signed: true,
                              ),
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                          Container(
                            height: 38.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 0.0,
                                      ),
                                    ),
                                  ),
                                  child: InkWell(
                                    child: Icon(
                                      Icons.arrow_drop_up,
                                      size: 18.0,
                                    ),
                                    onTap: () {
                                      int currentValue = int.parse(
                                          _overtimeHoursController.text);
                                      setState(() {
                                        currentValue++;
                                        _overtimeHoursController.text =
                                            (currentValue)
                                                .toString(); // incrementing value
                                      });
                                    },
                                  ),
                                ),
                                InkWell(
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    size: 20.0,
                                  ),
                                  onTap: () {
                                    int currentValue = int.parse(
                                        _overtimeHoursController.text);
                                    setState(() {
                                      print("Setting state");
                                      currentValue--;
                                      _overtimeHoursController.text =
                                          (currentValue > 0 ? currentValue : 0)
                                              .toString(); // decrementing value
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Container(
                        // margin: const EdgeInsets.all(11.0),
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.fromLTRB(10, 18, 10, 4),
                        child: Text(
                          'Overtime Rate*',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                // contentPadding: EdgeInsets.fromLTRB(15, 5, 10, 5),
                                contentPadding: EdgeInsets.all(8.0),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0.0))),
                              ),
                              controller: _overtimeRateController,
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: false,
                                signed: true,
                              ),
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                          Container(
                            height: 38.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 0.0,
                                      ),
                                    ),
                                  ),
                                  child: InkWell(
                                    child: Icon(
                                      Icons.arrow_drop_up,
                                      size: 18.0,
                                    ),
                                    onTap: () {
                                      int currentValue = int.parse(
                                          _overtimeRateController.text);
                                      setState(() {
                                        currentValue++;
                                        _overtimeRateController.text =
                                            (currentValue)
                                                .toString(); // incrementing value
                                      });
                                    },
                                  ),
                                ),
                                InkWell(
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    size: 20.0,
                                  ),
                                  onTap: () {
                                    int currentValue =
                                        int.parse(_overtimeRateController.text);
                                    setState(() {
                                      print("Setting state");
                                      currentValue--;
                                      _overtimeRateController.text =
                                          (currentValue > 0 ? currentValue : 0)
                                              .toString(); // decrementing value
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Container(
                        // margin: const EdgeInsets.all(11.0),
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.fromLTRB(10, 18, 10, 4),
                        child: Text(
                          'Tax Number*',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.fromLTRB(2, 0, 20, 0),
                        height: 48,
                        child: TextField(
                          controller: _taxNumberController,
                          decoration: InputDecoration(
                            hintText: '1234567',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0.0))),
                          ),
                        ),
                      ),

                      Container(
                        // margin: const EdgeInsets.all(11.0),
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.fromLTRB(10, 18, 10, 4),
                        child: Text(
                          'Bonus*',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.fromLTRB(2, 0, 20, 0),
                        height: 48,
                        child: TextField(
                          controller: _bonusController,
                          decoration: InputDecoration(
                            hintText: 'R00000',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0.0))),
                          ),
                        ),
                      ),

                      // Row(
                      //   children: <Widget>[
                      //     Container(
                      //       padding: EdgeInsets.fromLTRB(100, 19, 80, 12),
                      //       margin: const EdgeInsets.fromLTRB(11, 0, 0, 0),
                      //       // margin: const EdgeInsets.all(11.0),
                      //       alignment: Alignment.center,
                      //       decoration: BoxDecoration(
                      //           border: Border.all(color: Colors.black54)),
                      //       // padding: const EdgeInsets.only(
                      //       //left: 16.0, bottom: 15.0, top: 15.0, right: 16.0),
                      //       child: _filePath == null
                      //           ? new Text('Attach PaySlip')
                      //           : new Text('Path' + _filePath),
                      //
                      //       //padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      //     ),
                      //
                      //     Container(
                      //       padding: EdgeInsets.fromLTRB(0, 0, 0, 2),
                      //
                      //       child: RaisedButton(
                      //         padding: EdgeInsets.symmetric(vertical: 14.0),
                      //         onPressed: getFilePath,
                      //         // label: 'Select file',
                      //         child: Text(
                      //           'Browse',
                      //           style: TextStyle(
                      //             color: Colors.black,
                      //             fontWeight: FontWeight.w400,
                      //             fontSize: 17,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Container(
                        margin: const EdgeInsets.all(11.0),
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: RaisedButton(
                          color: Colors.lightBlue,
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            String stringValue = prefs.getString('token');
                            Map<String, String> headers = {
                              "content-type": "application/json",
                              "Accept": "application/json",
                              "X_TOKEN": "$stringValue",
                            };
                            final body = jsonEncode({
                              'id': _employeeController.text,
                              'paymentDate': _paymentDateController.text,
                              'mployeeName': names,
                              'hourlyRate': _hourlyRateController.text,
                              'monthlyHours': _monthlyHoursController.text,
                              'overtimeHours': _overtimeHoursController.text,
                              'overtimeRate': _overtimeRateController.text,
                              'taxNumber': _taxNumberController.text,
                              'bonus': _bonusController.text,
                            });
                            final response = await http.put(
                                'https://app.idolconsulting.co.za/idols/payslips',
                                headers: headers,
                                body: body);
                            setState(() {
                              print(body);
                              if (response.statusCode == 200) {
                                print(json.decode(response.body));
                              }
                            });
                            print("$stringValue");
                            print(json.decode(response.body));
                          },
                          child: Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(11.0),
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          '* Complete all required fields',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
