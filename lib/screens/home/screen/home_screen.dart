import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


import '../../../common_widget/appbar_widget/home_appbar_widget.dart';
import '../../../common_widget/loading_widget.dart';

import '../widgets/banner_widget.dart';
import '../home_controller.dart';
import '../widgets/popular_products_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBarWidget(
        context: context,
        controller: controller,
      ),

      body: Obx(() => controller.isLoading
          ? const Center(
              child: CustomLoadingWidget(),
            )
          : ListView(
              padding: const EdgeInsets.all(18),
              physics: const BouncingScrollPhysics(),
              children: [
                BannerWidget(bannerImages: controller.bannerData),
                const SizedBox(height: 20),
                PopularProducts(
                  controller: controller,
                ),


              ],
            )),


    );
  }
}
