//import 'dart:convert';
//import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
////import '../models/company.dart';
//import 'homescrean.dart';
//import 'Project.dart';
//import 'projectlist.dart';
//
//class CompanyServices {
//  //declaring url
//  static const String url =
//      "https://app.idolconsulting.co.za/idols/projects/5f3504f0c391b51061db90e3";
//  static const headers = {'': ''};
//  //getting users asynchronously
//  static Future<List<ProjectList>> getCompanies() async {
//   // Future<String> fetchProjects() async {
//    try {
//      //getting the url and storing in response
//      final response = await http.get(url);
//      //checking if the response is 200/successful
//      List<ProjectList> list = parseCompanies(response.body);
//      return list;
//    } catch (e) {
//      throw Exception(e.toString());
//    }
//  }
//
//  static List<ProjectList> parseCompanies(String responseBody) {
//    //return a list to users
//    //convert json to string and map it
//    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//    //call user from json and return the list
//    return parsed.map<ProjectList>((json) => ProjectList.fromJson(json)).toList();
//  }
//}