import 'package:flutter/material.dart';

import '../../../backend/models/product_model.dart';
import '../../../common_widget/text_labels/title_heading3_widget.dart';
import '../../../common_widget/text_labels/title_heading4_widget.dart';
import '../../../utils/assets_path.dart';
import '../home_controller.dart';

class ShoesProducts extends StatelessWidget {
  const ShoesProducts({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TitleHeading3Widget(
              text: "Shoes Products",
            ),
            TextButton(
                onPressed: () {
                  controller.seeAllPopularProducts(context);
                },
                child: const Text("See All")),
          ],
        ),
        SizedBox(
          height: 150,
          width: MediaQuery.of(context).size.width,
          child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
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
                              image: NetworkImage(data.image),
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
                                      text: data.name,
                                      color: Colors.white,
                                    ),
                                    Column(
                                      children: [
                                        TitleHeading3Widget(
                                          text: data.haveDiscount
                                              ? "${data.discountPrice.toStringAsFixed(2)} ${data.currency}"
                                              : "${data.price.toStringAsFixed(2)} ${data.currency}",
                                          color: Colors.black87,
                                        ),
                                        Visibility(
                                            visible: data.haveDiscount,
                                            child: Text(
                                              "${data.price.toStringAsFixed(2)} ${data.currency}",
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
              separatorBuilder: (context, i) => const SizedBox(width: 15),
              itemCount: controller.popularProductData.length >= 10
                  ? 10
                  : controller.popularProductData.length
              // itemCount: 5
              ),
        )
      ],
    );
  }
}
