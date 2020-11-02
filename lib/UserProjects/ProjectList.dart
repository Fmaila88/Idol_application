import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:App_idolconsulting/UserProjects/UserProjects.dart';

class ProjectServices {
  //declaring url
  static const String url =
  //    "https://app.idolconsulting.co.za/idols/projects/5f3504f0c391b51061db90e3";
         "https://app.idolconsulting.co.za/idols/projects/all";
 // static const headers = {'': ''};
  //getting users asynchronously
  static Future<List<UserProjects>> getProList() async {
    // Future<String> fetchProjects() async {
    try {
      //getting the url and storing in response
      var response = await http.get(url);
      //checking if the response is 200/successful
      List<UserProjects> list = getUserList(response.body);
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }


  }

  static List<UserProjects> getUserList(String responseBody) {
    //return a list to users
    //convert json to string and map it
    final parsed = json.decode(responseBody);
    //call user from json and return the list
    return parsed.map<UserProjects>((json) => UserProjects.fromJson(json)).toList();
  }
}