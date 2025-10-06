import 'dart:async';
import 'dart:developer';

import 'package:femtor/app/routes/app_pages.dart';
import 'package:femtor/app/utils/constants.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _startApp();
  }

  Future<void> _startApp() async {
    log("Splash Controller Started");
    await HapticFeedback.vibrate();
    log("Haptic Feedback Completed");
    log("Timer Start");
    Timer(Duration(seconds: 2), () async {
      log("After timer complete");
      final prefs = await SharedPreferences.getInstance();
      log("Shared Preferences Instance Created");
      final authToken = prefs.getString(AppConstants.keyAuthToken);

      log("Auth Token: $authToken");
      if (authToken != null && authToken.isNotEmpty) {
        log("Auth Token Not Null");
        Get.offAllNamed(Routes.HOME);
        log("Home Route Called");
      } else {
        log("Auth Token Null");
        Get.offAllNamed(Routes.ONBOARDING);
        log("Onboarding Route Called");
      }
      log("Timer Completed");
    });
    log("Timer Completed");
  }
}
