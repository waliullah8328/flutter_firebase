import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../backend/local_storage.dart';
import '../../../../backend/models/product_model.dart';
import '../../../../backend/paypal/paypal_payment.dart';
import '../../../../common_widget/appbar_widget/appbar_widget.dart';

import '../../../../common_widget/text_labels/title_heading3_widget.dart';
import '../../../../utils/assets_path.dart';
import '../../../../utils/strings.dart';
import '../cart/cart_controller.dart';

class ProductView extends StatelessWidget {
   ProductView({super.key, required this.products});
  final ProductModel products;
  final controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        appTitle: products.name,
        context: context,
        onBackClick: () => Get.back(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 250,
            child: FadeInImage(
              placeholder: AssetImage(Assets.productPlaceHolder),
              image: NetworkImage(products.image),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10,),
          SizedBox(
            height: 330,
            child: Column(
              children: [
                const Text("productDetails",style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(products.description),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const TitleHeading3Widget(text: "productPrice "),
                      TitleHeading3Widget(
                        text: products.haveDiscount
                            ? "${products.discountPrice.toStringAsFixed(2)} ${products.currency}"
                            : "${products.price.toStringAsFixed(2)} ${products.currency}",
                        color: Colors.black87,
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),


          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton.icon(onPressed: (){
                  _addToCart(context);
                },
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text("Add to cart"),
                ),

                ElevatedButton.icon(onPressed: (){

                  //LocalStorage.cartRemove();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PaypalPayment(
                      amount: controller.subTotal.toStringAsFixed(2),
                  onFinish: (value){
                  controller.addHistory(value);

                  },
                  )));

                },
                  icon: const Icon(Icons.sell_outlined),
                  label: const Text("Buy This Product"),
                ),
              ],
            ),


          ),




        ],
      ),
    );
  }

  void _addToCart(BuildContext context) async{

    await LocalStorage.saveProductToCart(product: products);
  }
}