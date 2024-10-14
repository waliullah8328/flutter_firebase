import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_widget/appbar_widget/appbar_widget.dart';
import 'btm_button.dart';
import 'btm_controller.dart';

class BottomNavScreen extends StatelessWidget {
  BottomNavScreen({super.key});

  final controller = Get.put(BTMController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: controller.selectedBody.value == 1
              ? AppBarWidget(
                  appTitle: "Order Details",
                  context: context,
                  onBackClick: () => controller.selectedBody.value = 0,
                )
              : null,
          body: controller.body[controller.selectedBody.value],
          bottomNavigationBar: _btmWidget(context),
        ));
  }

  _btmWidget(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.grey.withOpacity(.5),
      padding: const EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          BTMButtonWidget(
            onTap: () {
              controller.selectedBody.value = 0;
            },
            text: "Home",
            icon: Icons.home_max_rounded,
            opacity: controller.selectedBody.value == 0 ? 1 : .3,
          ),
          BTMButtonWidget(
            onTap: () {
              controller.selectedBody.value = 1;
            },
            text: "Order",
            icon: Icons.production_quantity_limits_sharp,
            opacity: controller.selectedBody.value == 1 ? 1 : .3,
          ),
        ],
      ),
    );
  }
}
