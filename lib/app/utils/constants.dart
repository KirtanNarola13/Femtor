import 'package:flutter/material.dart';

class AppConstants {
  // API Paths
  static const String baseUrl = "https://api.femtor.com/v1"; // Dummy URL
  static const String loginEndpoint = "/auth/login";
  static const String coursesEndpoint = "/courses";

  // Shared Preferences Keys
  static const String keyUserData = "user_data";
  static const String keyAuthToken = "auth_token";
}

class AppColors {
  static const Color primaryColor = Color(0xFF944E63);
  static const Color secondaryColor = Color(0xFF000000); // Black
  static const Color accentColor = Color(0xFFE196AC);
  static const Color textColor = Color(0xFF333333);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color textFieldBgColor = Color(0xFFEEEEEE);

  static const Gradient buttonGradient = LinearGradient(
    colors: [Color(0xFF944E63), Color(0xFFE196AC)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

class Images {
  // svg
  static const String icGoogleLogo = "assets/svg/google_logo.svg";
  static const String icAppleLogo = "assets/svg/apple_logo.svg";
  static const String icPhoneLogo = "assets/svg/phone_icon.svg";

  // Home Screen View
  static const String icHome = "assets/svg/ic_home.svg";
  static const String icContinueNav = "assets/svg/ic_continue_nav.svg";
  static const String icSearch = "assets/svg/ic_search.svg";
  static const String icProfile = "assets/svg/ic_profile.svg";

  // Home View
  static const String icFemtorTextLogo = "assets/svg/femtor_text_logo.svg";
  // png
  static const String logoPath = "assets/images/app_logo.png"; // Confirmed path
  static const String Dummy1Category = "assets/images/1.png"; // Confirmed path
  static const String Dummy2Category = "assets/images/2.png"; // Confirmed path
  static const String Dummy3Category = "assets/images/3.png"; // Confirmed path
  static const String anyaGuptaDummy =
      "assets/images/anaya_gupta.png"; // Confirmed path
  static const String kavyaMahikaDummy =
      "assets/images/kavya_mahika.png"; // Confirmed path
  static const String dummyCarouselImage =
      "assets/images/dummy_carosuler_slider.png"; // Confirmed path

  // Pro screen

  static const String proScreenBgImage =
      "assets/images/pro_screen_bg.png"; // Confirmed path
}
