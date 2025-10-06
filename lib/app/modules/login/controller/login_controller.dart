import 'package:femtor/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late TextEditingController phoneController;
  late TextEditingController emailController;
  var isUserInIndia = false.obs;
  var isButtonEnabled = false.obs;

  @override
  void onInit() {
    super.onInit();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    _checkUserLocale();

    phoneController.addListener(() {
      isButtonEnabled.value = phoneController.text.isNotEmpty;
    });
    emailController.addListener(() {
      isButtonEnabled.value = emailController.text.isNotEmpty;
    });
  }

  @override
  void onClose() {
    phoneController.dispose();
    emailController.dispose();
    super.onClose();
  }

  void _checkUserLocale() {
    final locale = Get.deviceLocale;
    if (locale != null && locale.countryCode == 'IN') {
      isUserInIndia.value = true;
    } else {
      isUserInIndia.value = true;
    }
  }

  void proceedToVerification() {
    HapticFeedback.mediumImpact();
    if (isButtonEnabled.value) {
      if (isUserInIndia.value) {
        final phone = phoneController.text;
        if (phone.isNotEmpty && phone.length >= 10) {
          print("Sending OTP to $phone");
          Get.toNamed(Routes.OTP, arguments: {'contact': "+91 $phone"});
        } else {
          Get.snackbar("Error", "Please enter a valid 10-digit phone number");
        }
      } else {
        final email = emailController.text;
        if (GetUtils.isEmail(email)) {
          print("Sending OTP to $email");
          Get.toNamed(Routes.OTP, arguments: {'contact': email});
        } else {
          Get.snackbar("Error", "Please enter a valid email address");
        }
      }
    }
  }

  void signInWithApple() {
    HapticFeedback.mediumImpact();
    print("Sign in with Apple tapped");
    // TODO: Implement Apple Sign In logic
  }

  void signInWithGoogle() {
    HapticFeedback.mediumImpact();
    print("Sign in with Google tapped");
    // TODO: Implement Google Sign In logic
  }
}
