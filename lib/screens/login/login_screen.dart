
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/signup/sign_up_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../common_widget/input_feild_widgets/password_input_feild_widget.dart';
import '../../common_widget/input_feild_widgets/primary_input_feild_widget.dart';

import '../../routes/routes.dart';
import '../../utils/strings.dart';
import 'login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _controller = Get.put(LoginController());
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _controller.formKey,
          child: ListView(padding: const EdgeInsets.all(10), children: [
            const SizedBox(height: 50),

/*
            TitleSubTitleWidget(
                title: Strings.loginScreen,
                subtitle: Strings.loginScreenSubTitle),
            */
            const SizedBox(
              height: 10,
            ),
            PrimaryTextInputWidget(
                controller: _controller.emailController,
                hintext: "Email",
                bordercolor: Colors.green,
                keyboardtype: TextInputType.emailAddress),
            const SizedBox(
              height: 10,
            ),
            PasswordTextInputWidget(
              controller: _controller.passController,
              hintext: "Enter Your Password",
              bordercolor: Colors.blue,
              keyboardtype: TextInputType.name,
            ),
            const SizedBox(
              height: 10,
            ),

            Obx(() => RadioListTile(
                title: const Text("Admin"),
                value: 1,
                groupValue: _controller.selectValue.value,
                dense: true,
                onChanged: (value) {
                  _controller.selectValue.value = value!;
                })),

            Obx(() => RadioListTile(
                title: const Text("User"),
                value: 2,
                groupValue: _controller.selectValue.value,
                dense: true,
                onChanged: (value) {
                  _controller.selectValue.value = value!;
                })),

            Obx(() => CheckboxListTile(
                title: const Text(
                  "Do you want to save password & email",
                  style: TextStyle(fontSize: 13),
                ),
                value: _controller.isChecked.value,
                dense: true,
                onChanged: (value) {
                  _controller.isChecked.value = value!;
                  box.write('lastScreen', true);
                })),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _controller.loginAction,
                child: const Text("Login"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have account?"),
                TextButton(onPressed: (){
                 // Get.toNamed(Routes.signUpScreen);
                  Get.to(()=> SignUpScreen());
                }, child: const Text("Sign Up")),
              ],
            )
          ]),
        ),
      ),
    );
  }


}
