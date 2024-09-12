import 'package:demo_ecommerce/controllers/product_controller.dart';
import 'package:demo_ecommerce/models/product_model.dart';
import 'package:demo_ecommerce/views/components/appbar_widget.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';


class ProductDetails extends StatefulWidget {
  final ProductModel product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  var productController = Get.put(ProductController());
  @override
  void initState() {
    Future.delayed(Duration.zero,(){
      productController.isFav(widget.product.id.toString());
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: appbarWidget(title: widget.product.title),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(widget.product.images![0],height: Get.height*0.3,width: Get.width,fit: BoxFit.contain,),
              const SizedBox(height: 10,),
              Text(widget.product.title!,style: theme.textTheme.titleLarge,),
              const SizedBox(height: 10,),
              Text("₹ ${widget.product.price!}",style: theme.textTheme.bodyMedium,),
              const SizedBox(height: 10,),
              Text(widget.product.description!,style: theme.textTheme.bodyMedium,),
              const SizedBox(height: 30,),
              ElevatedButton(
                  onPressed: (){
                    if(productController.isFavourite.value){
                      productController.removeFromFavourite(widget.product.id.toString());
                    }else{
                      productController.addToFavourite(widget.product.id.toString());
                    }
                  },
                  style: theme.textButtonTheme.style,
                  child: Container(
                    height: 50,
                    width: Get.width,
                    alignment: Alignment.center,
                    child: Obx(()=>Text(productController.isFavourite.value?"Remove from favourite":"Add to favourite",
                      style: theme.textTheme.bodyMedium,
                    ),)
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
