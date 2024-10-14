

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../backend/models/banners_model.dart';
import '../../../common_widget/text_labels/title_heading3_widget.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key, required this.bannerImages});

  final List<BannerModel> bannerImages;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 3, // You can adjust the aspect ratio as needed
        viewportFraction: .8,
        enlargeCenterPage: false,
      ),
      items: bannerImages.map((data) {
        return Builder(
          builder: (BuildContext context) {
            return buildBanner(data, context);
          },
        );
      }).toList(),
    );
  }

  buildBanner(BannerModel data, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(data.image),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(.3)
              ),
              child: TitleHeading3Widget(
                  text: data.title,
                color: Colors.white,
              )
          )
        ],
      ),
    );
  }
}