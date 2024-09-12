import 'package:flutter/material.dart';
import 'package:get/get.dart';

appbarWidget({String? title}){
  return AppBar(
    title: title==null? Image.asset("images/logo.png"):
    Text(title),
    actions: [
      IconButton(onPressed: (){}, icon: const Icon(Icons.search,color: Colors.white,)),
      IconButton(onPressed: (){}, icon: const Icon(Icons.shopping_cart_rounded,color: Colors.white,))
    ],
  );
}
