import 'package:femtor/app/data/api/api_helper.dart';
import 'package:femtor/app/routes/app_pages.dart';
import 'package:femtor/app/utils/dialog_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../create_account/model/user_model.dart';

class OtpController extends GetxController {
  TextEditingController otpController = TextEditingController();
  late String contactInfo;

  var isButtonEnabled = false.obs;
  var hasError = false.obs;
  final ApiHelper _apiHelper = ApiHelper();

  @override
  void onInit() {
    super.onInit();
    otpController = TextEditingController();
    contactInfo = Get.arguments['contact'] ?? '';
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }

  Future<void> verifyOtp() async {
    HapticFeedback.mediumImpact();
    final otp = otpController.text;

    DialogHelper.showLoading('Verifying OTP...');

    // Simulate API call
    final response = await _apiHelper.verifyOtp(otp);

    DialogHelper.hideLoading();

    if (response['status'] == 'success') {
      hasError.value = false;
      if (response['user_exists'] == true) {
        // User exists, navigate to Home
        final user = UserModel.fromJson(response['user_data']);
        // TODO: Save user data to SharedPreferences
        print("User exists. Navigating to Home. Data: ${user.toJson()}");
        Get.offAllNamed(Routes.HOME);
      } else {
        // New user, navigate to Create Profile
        print("New user. Navigating to Create Profile.");
        Get.toNamed(Routes.CREATE_PROFILE, arguments: {'contact': contactInfo});
      }
    } else {
      hasError.value = true;
      Get.snackbar("Error", response['message'] ?? "Invalid OTP");
    }
  }

  void resendOtp() {
    HapticFeedback.mediumImpact();
    print("Resending OTP to $contactInfo");
    // TODO: Add resend OTP logic
    Get.snackbar("Info", "OTP has been resent to $contactInfo");
  }
}
