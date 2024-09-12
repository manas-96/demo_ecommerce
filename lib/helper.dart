import 'package:flutter/material.dart';
import 'package:get/get.dart';

errorHandler(Map data){
  if(data.containsKey("message")){
    Get.snackbar("Message", data["message"],colorText: Colors.red);
  }
  if(data.containsKey("errors")){
    Get.snackbar("Errors", data["errors"],colorText: Colors.red);
  }
}