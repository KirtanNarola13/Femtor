import 'dart:async';

import 'package:femtor/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  late PageController pageController;
  Timer? _timer;
  var currentPage = 0.obs;
  var isUserInIndia = false.obs;

  final List<Map<String, String>> onboardingPages = [
    {
      'title': 'Explore Makeup Courses',
      'subtitle': 'From everyday looks to creative artistry.',
    },
    {
      'title': 'Learn from Experts',
      'subtitle': 'Guided by professional makeup artists.',
    },
    {
      'title': 'Create Your Style',
      'subtitle': 'Practice, experiment, and express yourself.',
    },
  ];

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    _startAutoScroll();
    _checkUserLocale();
  }

  @override
  void onClose() {
    _timer?.cancel();
    pageController.dispose();
    super.onClose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (currentPage.value < onboardingPages.length - 1) {
        currentPage.value++;
      } else {
        currentPage.value = 0;
      }
      pageController.animateToPage(
        currentPage.value,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    });
  }

  void _checkUserLocale() {
    final locale = Get.deviceLocale;
    print("Device Locale: ${locale?.countryCode}");
    if (locale != null && locale.countryCode == 'IN') {
      isUserInIndia.value = true;
    } else {
      isUserInIndia.value = false;
    }
  }

  // --- Button Actions ---

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

  void continueWithPhoneOrEmail() {
    HapticFeedback.mediumImpact();
    Get.toNamed(Routes.LOGIN);
  }
}
