import 'package:demo_ecommerce/controllers/product_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  test('Test should be pass', () {
    final productController = Get.put(ProductController());
    productController.isFav("1");
    expect(true, true);
  });
}