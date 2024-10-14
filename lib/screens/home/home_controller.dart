import 'package:flutter/material.dart';
import 'package:flutter_firebase/backend/models/product_model.dart';
import 'package:flutter_firebase/screens/home/subs_screens/all_products/all_products_screen.dart';
import 'package:flutter_firebase/screens/home/subs_screens/cart/cart_screen.dart';
import 'package:flutter_firebase/screens/home/subs_screens/products_view/product_view_screen.dart';
import 'package:flutter_firebase/utils/logger.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../backend/models/banners_model.dart';
import '../../backend/services/firebase_service.dart';
import '../../routes/routes.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    fetchBanners();
    _fetchPopularProducts();
    super.onInit();
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  /// Initialize your lists as empty to avoid null check issues
  List<BannerModel> bannerData = [];
  List<ProductModel> popularProductData = [];
  List<ProductModel> bestSellingProductData = [];

  /// fetching banners
  void fetchBanners() async {
    _isLoading.value = true;
    update();
    "START FETCHING BANNER ".bgGreenConsole;

    try {
      bannerData = (await FirebaseServices.fetchBanner()) ?? [];

      bannerData.toString().yellowConsole;
      _fetchPopularProducts();
    } catch (e) {
      e.toString().redConsole;
    } finally {
      // _isLoading.value = false;
      // update();
    }
  }

  /// fetching popular products
  void _fetchPopularProducts() async {
    "START FETCHING Popular Product ".bgGreenConsole;

    try {
      popularProductData = (await FirebaseServices.fetchPopularProduct()) ?? [];
      _fetchBestSellingProducts();
    } catch (e) {
      e.toString().redConsole;
    } finally {
      // _isLoading.value = false;
      // update();
    }
  }

  /// fetching best selling products
  void _fetchBestSellingProducts() async {
    "START FETCHING Best Selling Product ".bgGreenConsole;

    try {
      bestSellingProductData = (await FirebaseServices.fetchBestSellingProducts()) ?? [];
    } catch (e) {
      e.toString().redConsole;
    } finally {
      _isLoading.value = false;
      update();
    }
  }

  /// routing functions with pass data
  void goToDetailsScreen(ProductModel data, BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductView(
              products: data,
            )));
  }

  void seeAllPopularProducts(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AllProductsScreen(
              products: popularProductData,
              appTitle: "All Popular Products",
            )));
  }

  void goToCartScreen() {
    //Get.toNamed(Routes.cartScreen);
    Get.to(()=> CartScreen());
  }
}
