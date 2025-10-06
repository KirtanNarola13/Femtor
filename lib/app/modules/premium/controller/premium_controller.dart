import 'package:confetti/confetti.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PremiumController extends GetxController {
  var selectedIndex = 2.obs; // Default to yearly plan
  ConfettiController confettiController = ConfettiController();

  void selectPlan(int index) {
    HapticFeedback.lightImpact();
    selectedIndex.value = index;
  }

  void continueToPayment() {
    HapticFeedback.mediumImpact();

    // // 🎉 Show confetti
    // confettiController.play();

    print("Continue with plan: ${selectedIndex.value}");

    Get.back();
  }
}
