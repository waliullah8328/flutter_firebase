
import 'package:get/get.dart';

import '../home/screen/home_screen.dart';
import '../order_history/order_history_screen.dart';


class BTMController extends GetxController{
  RxInt selectedBody = 0.obs;


  List body = [
    HomeScreen(),
    OrderHistoryScreen()
  ];
}