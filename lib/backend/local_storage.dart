import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';

import 'models/product_model.dart';


const String tokenKey = "tokenKey";
const String emailKey = "emailKey";
const String isLoggedInKey = "isLoggedInKey";
const String isDataLoadedKey = "isDataLoadedKey";
const String isOnBoardDoneKey = "isOnBoardDoneKey";


const String productCart = "productCart";


class LocalStorage {

  static Future<void> saveProductToCart({required ProductModel product}) async {
    final box = GetStorage();
    List<Map<String, dynamic>> lastValues = GetStorage().read(productCart)?.cast<Map<String, dynamic>>() ?? [];

    Map<String, dynamic> productMap = product.toJson();

    print(lastValues);
    print(lastValues.length);

    lastValues.add(productMap);

    print(lastValues);
    print(lastValues.length);

    await box.write(productCart, lastValues);
  }

  static Future<void> removeProductFromCart({required ProductModel product}) async {
    final box = GetStorage();
    List<Map<String, dynamic>> lastValues = GetStorage().read(productCart)?.cast<Map<String, dynamic>>() ?? [];


    print(lastValues);
    print(lastValues.length);


      int index = 0;
      for (var element in lastValues) {
        if(element["id"] == product.id){
          lastValues.removeAt(index);
          break;
        }
        index++;
      }

    // lastValues.add(productMap);

    print(lastValues);
    print(lastValues.length);

    await box.write(productCart, lastValues);
  }

  static List<ProductModel> currentCart() {
    List<Map<String, dynamic>> products = GetStorage().read(productCart)?.cast<Map<String, dynamic>>() ?? [];

    print(products);
    print(products.length);

    List<ProductModel> convertedProducts = products.map((e) => ProductModel.fromJson(e)).toList();
    return convertedProducts;
  }

  static Future<void> cartRemove() async {
    final box = GetStorage();
    await box.remove(productCart);
  }




  static Future<void> saveEmail({required String email}) async {
    final box = GetStorage();

    await box.write(emailKey, email);
  }

  static Future<void> saveToken({required String token}) async {
    final box = GetStorage();

    await box.write(tokenKey, token);
  }

  static Future<void> isLoginSuccess({required bool isLoggedIn}) async {
    final box = GetStorage();

    await box.write(isLoggedInKey, isLoggedIn);
  }

  static Future<void> dataLoaded({required bool isDataLoad}) async {
    final box = GetStorage();

    await box.write(isDataLoadedKey, isDataLoad);
  }

  static Future<void> saveOnboardDoneOrNot(
      {required bool isOnBoardDone}) async {
    final box = GetStorage();

    await box.write(isOnBoardDoneKey, isOnBoardDone);
  }

  static String? getEmail() {
    return GetStorage().read(emailKey) ?? "";
  }

  static String? getToken() {
    var rtrn = GetStorage().read(tokenKey);

    debugPrint(rtrn == null ? "##Token is null###" : "");

    return rtrn;
  }

  static bool isLoggedIn() {
    return GetStorage().read(isLoggedInKey) ?? false;
  }

  static bool isDataLoaded() {
    return GetStorage().read(isDataLoadedKey) ?? false;
  }

  static bool isOnBoardDone() {
    return GetStorage().read(isOnBoardDoneKey) ?? false;
  }

  static Future<void> logout() async {
    final box = GetStorage();
    await box.remove(emailKey);
    await box.remove(isLoggedInKey);
    await box.remove(tokenKey);
  }

}
