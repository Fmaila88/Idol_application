import 'dart:convert';
import 'package:App_idolconsulting/TravelAllowance/Model/Allowance_Model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Services {

  //Getting a list of allowance from server
  static Future<List<Allowance_Model>> getAllowance() async {
    final String url = 'https://app.idolconsulting.co.za/idols/travel-allowance/all';
    try {
      final response = await http.get(url);
      //checking if the response is 200/successful
      List<Allowance_Model> list = parseAllowance(response.body);
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<Allowance_Model> parseAllowance(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Allowance_Model>((json) => Allowance_Model.fromJson(json))
        .toList();
  }

  //Post or update data
  // static Future<Allowance_Model> createAllowance(Allowance_Model model) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String stringValue = prefs.getString('token');
  //
  //   final String url = 'https://app.idolconsulting.co.za/idols/travel-allowance';
  //   final headers = {
  //     "content-type": "application/json",
  //     "Accept": "application/json",
  //     "X_TOKEN": "$stringValue",
  //   };
  //   final response = http.put(url, headers: headers, body: json.encode(model.toJson()));
  //   print(response);
  // }

  //Get allowance from server as a Map (Per user)
  // Future getAllowancePerUser() async {
  //   final String url = 'https://app.idolconsulting.co.za/idols/travel-allowance/all';
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String token = prefs.getString('token');
  //
  //   final response = await http.get(url, headers: {
  //     "content-type": "application/json",
  //     "Accept": "application/json",
  //     "X_TOKEN": "$token",
  //   });
  //   try {
  //     Map map = jsonDecode(response.body);
  //     var data = Allowance_Model.fromJson(map);
  //     return data;
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }
}
