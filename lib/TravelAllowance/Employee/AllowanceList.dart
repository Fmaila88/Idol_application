import 'dart:convert';
import 'package:App_idolconsulting/TravelAllowance/EmployeeData.dart';
import 'package:http/http.dart' as http;

class AllowanceServices {
  static const String url =
      "https://app.idolconsulting.co.za/idols/travel-allowance/1/10/ASC/CreatedDate";
  static Future<List<EmployeeData>> getProList() async {
    try {
      //getting the url and storing in response
      var response = await http.get(url);
      //checking if the response is 200/successful
      List<EmployeeData> list = getUserList(response.body);
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }


  }

  static List<EmployeeData> getUserList(String responseBody) {
    //return a list to users
    //convert json to string and map it
    final parsed = json.decode(responseBody);
    //call user from json and return the list
    return parsed.map<EmployeeData>((json) => EmployeeData.fromJson(json)).toList();
  }
}