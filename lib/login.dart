import 'package:flutter/material.dart';
import 'package:App_idolconsulting/HomePage/homescrean.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
//import 'FadeAnimation.dart';

class LoginBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Login();
  }
}

class _Login extends State<LoginBody> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  var response;

  String message = '';

  Future userLogin(String username, String password) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Builder(builder: (BuildContext context){
          return  Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/backend.jpg'), fit: BoxFit.fill)),
            child: ListView(
              children: <Widget>[
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/logo1.png'),
                          fit: BoxFit.cover)),
                ),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, 3),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10),
                                )
                              ]),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom:
                                        BorderSide(color: Colors.grey[900]))),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Email",
                                      hintStyle:
                                      TextStyle(color: Colors.grey[400])),
                                  controller: emailController,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle:
                                      TextStyle(color: Colors.grey[400])),
                                  obscureText: true,
                                  controller: passController,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
//                              gradient: LinearGradient(colors: [
//                                Color.fromRGBO(143, 148, 251, 1),
//                                Color.fromRGBO(143, 148, 251, 6),
//                              ]
                              )),
                           RaisedButton(
                            textColor: Colors.white,
                            color: Colors.lightBlue[900],
                            child: Text('Login'),
                            onPressed: () async {
                              if (formKey.currentState.validate()) {
                                setState(() {
                                  //message = 'please wait';
                                });

                                Map<String, String> headers = {
                                  "content-type": "application/json",
                                  "Accept": "application/json"
                                };
                                final body = jsonEncode({
                                  'username': emailController.text,
                                  'password': passController.text,
                                });
                                SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                                response = await http.post(
                                    'https://app.idolconsulting.co.za/idols/users/login',
                                    headers: headers,
                                    body: body);

                                var loginMessage;
                                print(response.statusCode);
                                if (response.statusCode == 200) {
                                  message = "login success";

                                  loginMessage = json.decode(response.body);
                                  String nn=loginMessage['token'];

                                  SharedPreferences pref=await SharedPreferences.getInstance();
                                  pref.setString('userToken',nn);

                                  setState(() {


                                    //If the authentication is successful switch to the home page
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Home()));
                                    // loginMessage['message'];
                                    //print(loginMessage.toString());
                                  });
                                  sharedPreferences.setString(
                                      "token", loginMessage['token']);
                                } else {
                                  loginMessage = json.decode(response.body);
                                  setState(() {
                                    message = "login failed";
                                  });
                                  //Display the server message to the user if the login failed
                                  // return new Text( loginMessage['message'],style: TextStyle(fontSize: 50,color: Colors.green),);

                                  Scaffold.of(context).showSnackBar(SnackBar(content: Text(loginMessage['message']),));

                                }

                              }
                            },
                          ),
                       // ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        )

    );
  }
}
