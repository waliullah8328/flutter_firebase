import 'package:get/get.dart';


import '../../../../backend/local_storage.dart';
import '../../../../backend/models/product_model.dart';

import '../../../../routes/routes.dart';
import '../../../../services/firebase_service.dart';

class CartController extends GetxController{

  late List<ProductModel> products;

  @override
  void onInit() {
    products = LocalStorage.currentCart();
    _productsPriceManage(products);
    super.onInit();
  }

  double subTotal = 0;
  double deliveryCharge = 50;
  void _productsPriceManage(List<ProductModel> products) {
    for (var element in products) {
      if(element.haveDiscount){
        subTotal += element.discountPrice+deliveryCharge;
      }else{
        subTotal += element.price+deliveryCharge;
      }

    }
  }

  void addHistory(value) async{

    List<Map<String, dynamic>> convertToMapProducts = products.map((product) => product.toJson()).toList();


    Map<String, dynamic> orderDetails = {
      "orderId": value.toString(),
      "total": subTotal + deliveryCharge,
      "others": convertToMapProducts,
      // ... add others fields
    };

      await FirebaseServices.setOrderData(orderDetails, value.toString());

    Get.snackbar("Payment Success", "Successfully placed the order.");
    LocalStorage.cartRemove();
    Get.offAllNamed(Routes.btmNavScreen);
  }
}