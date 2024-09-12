import 'dart:convert';

import 'package:demo_ecommerce/services/api_service.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductController extends GetxController{
  var products=<ProductModel>[].obs;
  var limit = 10.obs;
  Future<List<ProductModel>>getProducts()async{
    final result = await ApiService().getFunction("/products?limit=${limit.value}&total=10");
    products.clear();
    if(result!="failed" && result["products"].isNotEmpty){
      for(var items in result["products"]){
        products.add(ProductModel.fromJson(items));
      }
    }
    return products;
  }
  filterProductByTitle(String title){
    if(title==""){
      getProducts();
      return;
    }
    for(int i=0; i<products.length;i++){
      if(products[i].title!.toLowerCase().contains(title.toLowerCase())){
        var temp =products[i];
        products.removeAt(i);
        products.insert(0, temp);
      }
    }
  }
  var isFavourite = false.obs;
  isFav(String productId)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List fav = json.decode(preferences.getString("fav")??"[]");
    if(fav.contains(productId)) {
      isFavourite.value=true;
      return;
    }
    isFavourite.value=false;
  }
  addToFavourite(String productId)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List fav = json.decode(preferences.getString("fav")??"[]");
    if(fav.contains(productId)) return;
    fav.add(productId);
    preferences.setString("fav", json.encode(fav));
    Get.snackbar("Message", "Product added to favourite",);
    isFav(productId);
  }
  removeFromFavourite(String productId)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List fav = json.decode(preferences.getString("fav")??"[]");
    late int position;
    for(int i=0;i<fav.length;i++){
      if(fav[i]==productId){
        position = i;
      }
    }
    fav.removeAt(position);
    preferences.setString("fav", json.encode(fav));
    isFav(productId);
    Get.snackbar("Message", "Product remove from favourite",);
  }
}