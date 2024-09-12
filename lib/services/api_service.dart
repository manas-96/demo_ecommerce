import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;

import '../helper.dart';



class ApiService{
  static const baseUrl = "https://dummyjson.com";
  _buildHeader(){
    return { 'Accept' : 'application/json', 'cache-control' : 'no-cache'};
  }
  getFunction(url)async{
    try{
      final response = await http.get(Uri.parse("$baseUrl$url"),headers: _buildHeader());
      print(response.body);
      if(response.statusCode==200){
        return jsonDecode(response.body);
      }
      else{
        errorHandler(jsonDecode(response.body));
        return "failed";
      }
    }
    catch(e){
      print(e);
      Get.snackbar("Error", e.toString(),colorText: Colors.red);
      return "failed";
    }
  }

}