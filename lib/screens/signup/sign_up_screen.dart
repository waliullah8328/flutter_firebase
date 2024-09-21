import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_widget/input_feild_widgets/password_input_feild_widget.dart';
import '../../common_widget/input_feild_widgets/primary_input_feild_widget.dart';

import 'sign_up_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final controller = Get.put(SignUpController());


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [

            const SizedBox(
              height: 50,
            ),

          /*  const TitleSubTitleWidget(
                title: "Sign Up Screen",
                subtitle: "Build Your profile by registration"),

           */

            const SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded( 
                  child: PrimaryTextInputWidget(
                      controller: controller.firstNameController,
                      hintext: "First Name",
                      bordercolor: Colors.green,
                      keyboardtype: TextInputType.name),
                ),

                const SizedBox(width: 10,),

                Expanded(
                  child: PrimaryTextInputWidget(
                      controller: controller.lastNameController,
                      hintext: "Last Name",
                      bordercolor: Colors.green,
                      keyboardtype: TextInputType.name),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            PrimaryTextInputWidget(
                controller: controller.emailController,
                hintext: "Email",
                bordercolor: Colors.green,
                keyboardtype: TextInputType.emailAddress),
            const SizedBox(
              height: 10,
            ),
            PrimaryTextInputWidget(
                controller: controller.phoneNameController,
                hintext: "Phone Number",
                bordercolor: Colors.green,
                keyboardtype: TextInputType.number),
            const SizedBox(
              height: 10,
            ),
            PasswordTextInputWidget(
                controller: controller.passwordController,
                hintext: "Enter Password",
                bordercolor: Colors.green,
                keyboardtype: TextInputType.name),
            const SizedBox(
              height: 10,
            ),
            PasswordTextInputWidget(
                controller: controller.confirmController,
                hintext: "Confirm Password",
                bordercolor: Colors.green,
                keyboardtype: TextInputType.name),
            const SizedBox(
              height: 10,
            ),
            Obx(() =>RadioListTile(
                title: const Text("Admin"),
                value: 1,
                groupValue: controller.selectValue.value,
                dense: true,
                onChanged: (value) {
                  controller.selectValue.value = value!;
                })),
            Obx(() => RadioListTile(
                title: const Text("User"),
                value: 2,
                groupValue: controller.selectValue.value,
                dense: true,
                onChanged: (value) {
                  controller.selectValue.value = value!;
                })),
            Obx(() => CheckboxListTile(
                title: const Text(
                  "Agree with T&C and Privacy Policy?",
                  style: TextStyle(fontSize: 13),
                ),
                value: controller.isChacked.value,
                dense: true,
                onChanged: (value) {
                  controller.isChacked.value = value!;
                })),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: controller.signUpAction,
                child: const Text("Registration"),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
