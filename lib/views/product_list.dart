import 'package:demo_ecommerce/controllers/product_controller.dart';
import 'package:demo_ecommerce/models/product_model.dart';
import 'package:demo_ecommerce/views/components/appbar_widget.dart';
import 'package:demo_ecommerce/views/components/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'product_details.dart';


class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  var productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: appbarWidget(title: "Products"),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification &&
              notification.metrics.extentAfter == 0) {
            productController.limit.value=productController.limit.value+10;
            productController.getProducts();
          }
          return false;
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Obx(()=>productController.products.isEmpty?
                  const SizedBox():
                  Container(
                    decoration:  BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: const [
                          BoxShadow(blurRadius: 1,color: Colors.grey)
                        ]
                    ),
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6,),
                        child: TextField(
                          onChanged: (val){
                            productController.filterProductByTitle(val);
                          },
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search products"
                          ),
                        )
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                FutureBuilder(
                  future: productController.getProducts(),
                  builder: (context,snap){
                    if(snap.connectionState==ConnectionState.waiting) return loader();
                    if(productController.products.isEmpty) return const Center(child: Text("No product found"),);
                    return Obx(()=>GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1/1.3
                      ),
                      itemCount: productController.products.length+1,
                      itemBuilder: (context,index){
                        if (index < productController.products.length){
                          return Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: const[
                                  BoxShadow(color: Colors.grey, blurRadius: 0.2)
                                ]
                            ),
                            child: InkWell(
                              onTap: (){
                                Get.to(ProductDetails(product: productController.products[index],));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Image.network(productController.products[index].images![0],fit: BoxFit.cover,),
                                    ),
                                    const SizedBox(height: 5,),
                                    Text(productController.products[index].title!,style: theme.textTheme.titleSmall,maxLines: 2,),
                                    const SizedBox(height: 5,),
                                    Text("₹ ${productController.products[index].price!}/-",style: theme.textTheme.bodyMedium,),
                                    const SizedBox(height: 5,),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        else {
                          return loader();
                        }
                      },
                    ));
                  },
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
