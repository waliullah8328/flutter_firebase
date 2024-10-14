import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../backend/local_storage.dart';
import '../../../../backend/models/product_model.dart';
import '../../../../backend/paypal/paypal_payment.dart';
import '../../../../common_widget/appbar_widget/appbar_widget.dart';
import '../../../../common_widget/text_labels/title_heading2_widget.dart';
import '../../../../common_widget/text_labels/title_heading4_widget.dart';
import '../../../../routes/routes.dart';
import 'cart_controller.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(
          appTitle: "Cart",
          context: context,
          onBackClick: () => Get.back(),
        ),
        body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  controller.products.isEmpty
                      ? const Center(
                    child: Opacity(
                        opacity: .5,
                        child: Icon(
                          Icons.hourglass_empty,
                          size: 180,
                        )),
                  )
                      : Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          ProductModel data = controller.products[index];
                          return Container(
                            height: 60,
                            padding: const EdgeInsets.all(7),
                            margin: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                color: Colors.blueAccent.withOpacity(.2),
                                borderRadius: BorderRadius.circular(14)),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(7),
                                  child: Image.network(
                                    data.image,
                                    width: 70,
                                    height: 50,
                                    fit: BoxFit.fill,
                                  ),
                                ),

                                TitleHeading2Widget(text: data.name),

                                const Spacer(),

                                Row(
                                  children: [
                                    TitleHeading2Widget(
                                        text: (data.haveDiscount
                                            ? data.discountPrice
                                            : data.price)
                                            .toStringAsFixed(2)),
                                    TitleHeading2Widget(text: data.currency),

                                    IconButton(
                                        onPressed: (){
                                          LocalStorage.removeProductFromCart(product: data);

                                        },
                                        icon: const Icon(Icons.delete)
                                    )
                                  ],
                                ),


                              ],
                            ),
                          );
                        },
                        itemCount: controller.products.length),
                  ),


                  Visibility(
                    visible: controller.products.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const TitleHeading4Widget(text: "SubTotal:"),
                              TitleHeading2Widget(
                                  text: controller.subTotal.toStringAsFixed(2)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const TitleHeading4Widget(text: "Delivery Charge:"),
                              TitleHeading2Widget(
                                  text: controller.deliveryCharge.toStringAsFixed(2)),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                LocalStorage.cartRemove();
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> PaypalPayment(
                                  amount: controller.subTotal.toStringAsFixed(2),
                                  onFinish: (value){
                                    //
                                    controller.addHistory(value);

                                  },
                                )));

                              },
                              icon: const Icon(Icons.sell_outlined),
                              label: const Text("Buy"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ));



  }
}
