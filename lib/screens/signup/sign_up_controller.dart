import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/utils/logger.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';
import '../../services/firebase_service.dart';
import '../../toast_message.dart';
import '../../utils/app_config.dart';



class SignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();

  RxInt selectValue = 1.obs;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  RxBool isChacked = false.obs;

  void signUpAction() {
    if (formKey.currentState!.validate()) {
      if (GetUtils.isEmail(emailController.text)) {
        if (passwordRegex.hasMatch(passwordController.text) &&
            passwordController.text == confirmController.text) {
          emailController.text.greenConsole;
          passwordController.text.greenConsole;

          _signUpProcess();
        } else {
          Get.snackbar("Invalid Password", "Your password is not valid syntax");
        }

        /// todo login method
      } else {
        Get.snackbar("Invalid Email", "Your Email is not Valid");
      }
    }
  }

  ///
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  void _signUpProcess() async {
    _isLoading.value = true;
    update();

    try {
      final authService = FirebaseServices();

      final userCredential = await authService.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      final user = userCredential.user!;

      debugPrint('uid: ${user.uid}');
      _userFunctionDataStore(user, userCredential);
      ToastMessage.success("Registration Success.");
    } catch (e) {
      e.toString().redConsole;
    }

    _isLoading.value = false;
    update();
  }

  void _userFunctionDataStore(
      User user, UserCredential userCredential) async {

    Map<String, dynamic> customerData = {
      "id": user.uid,
      "email": emailController.text,
      "phoneNumber": phoneNameController.text,
      "name": "${firstNameController.text} ${lastNameController.text}",
      "image": user.photoURL,
      "address": "",
      "state": "",
      "city": "",
      "zip": "",
    };

    if (userCredential.additionalUserInfo!.isNewUser) {
      await FirebaseServices.setData( customerData);
      Get.offAllNamed(Routes.loginScreen);
    }
  }
}
