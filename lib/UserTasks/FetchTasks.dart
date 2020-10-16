
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'UserTasks.dart';


class FetchTasks{

  Map<String,dynamic> data0;
  UserTasks tasks;


  static const String url='https://app.idolconsulting.co.za/idols/tasks/1/10/DESC/createDate/5f3504f0c391b51061db90e3?keyword=';


  static Future<Map<String,dynamic>> getTasksDetails() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('userToken');

    try{

      var response=await http.get(url,headers: {"Accept": "application/json",
        "X_TOKEN": stringValue});

      Map<String,dynamic> tasks=getUserTasks(response.body);

      return tasks;

    }catch(e){
      throw Exception(e.toString());
    }

  }



  static Map<String,dynamic> getUserTasks(String response){

    final parsed=jsonDecode(response);
    return parsed.map<UserTasks>((json)=>UserTasks.fromJson(json));

  }



}