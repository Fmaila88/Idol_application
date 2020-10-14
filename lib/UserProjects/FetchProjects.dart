
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'package:App_idolconsulting/UserProjects/UserProjects.dart';


class FetchProjects{

  Map<String,dynamic> data;
  UserProjects projects;


  static const String url='https://app.idolconsulting.co.za/idols/projects/5f3504f0c391b51061db90e3';


  static Future<Map<String,dynamic>> getProjectDetails() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('userToken');

    try{

      var response=await http.get(url,headers: {"Accept": "application/json",
      "X_TOKEN": stringValue});

      Map<String,dynamic> projects=getUserProjects(response.body);

      return projects;

    }catch(e){
      throw Exception(e.toString());
    }

  }



  static Map<String,dynamic> getUserProjects(String response){

    final parsed=jsonDecode(response);
    return parsed.map<UserProjects>((json)=>UserProjects.fromJson(json));

  }



}