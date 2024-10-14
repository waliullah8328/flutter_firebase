import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../backend/models/product_model.dart';
import '../../../../common_widget/appbar_widget/appbar_widget.dart';
import '../../../../common_widget/text_labels/title_heading3_widget.dart';
import '../../../../common_widget/text_labels/title_heading4_widget.dart';
import '../../../../utils/assets_path.dart';
import '../../home_controller.dart';


class AllProductsScreen extends StatelessWidget {
    AllProductsScreen({super.key, required this.products, required this.appTitle});

  final List<ProductModel> products;
  final String appTitle;
  final controller = Get.put(HomeController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        appTitle: appTitle,
        context: context,
        onBackClick: () => Get.back(),
      ),

      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                 crossAxisSpacing: 11,
                mainAxisSpacing: 11
              ),
              itemBuilder: (context, index) {
                ProductModel data = controller.popularProductData[index];

                return InkWell(
                  onTap: () {
                    controller.goToDetailsScreen(data, context);
                  },


                  child: Container(
                    height: 150,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 150,
                          width: 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: FadeInImage(
                              placeholder: AssetImage(Assets.productPlaceHolder),
                              image: NetworkImage(products[index].image),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                height: 50,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(.7)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TitleHeading4Widget(
                                      text: products[index].name,
                                      color: Colors.white,
                                    ),
                                    Column(
                                      children: [
                                        TitleHeading3Widget(
                                          text: products[index].haveDiscount
                                              ? "${products[index].discountPrice.toStringAsFixed(2)} ${products[index].currency}"
                                              : "${products[index].price.toStringAsFixed(2)} ${products[index].currency}",
                                          color: Colors.black87,
                                        ),
                                        Visibility(
                                            visible: products[index].haveDiscount,
                                            child: Text(
                                              "${products[index].price.toStringAsFixed(2)} ${products[index].currency}",
                                              style: const TextStyle(
                                                  decoration:
                                                  TextDecoration.lineThrough,
                                                  fontSize: 12.0,
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            ))
                                      ],
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            itemCount: products.length,
          ),
        ),
      ),
    );
  }
}
