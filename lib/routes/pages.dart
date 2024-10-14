import 'package:get/get.dart';


import '../screens/btm/bottom_nav_screen.dart';
import '../screens/home/screen/home_screen.dart';
import '../screens/home/subs_screens/cart/cart_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/signup/sign_up_screen.dart';
import 'routes.dart';

class Pages {
  static var list = [

    GetPage(
      name: Routes.loginScreen,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: Routes.signUpScreen,
      page: () => SignUpScreen(),
    ),

    GetPage(
      name: Routes.btmNavScreen,
      page: () => BottomNavScreen(),
    ),
    GetPage(
      name: Routes.homeScreen,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: Routes.cartScreen,
      page: () => CartScreen(),
    ),


  ];
}
