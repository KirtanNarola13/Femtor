import 'package:get/get.dart';

import '../modules/create_account/binding/create_profile_binding.dart';
import '../modules/create_account/view/create_profile_view.dart';
import '../modules/home_screen/binding/home_screen_binding.dart';
import '../modules/home_screen/view/home_screen_view.dart';
import '../modules/home_view/binding/home_view_binding.dart';
import '../modules/login/binding/login_binding.dart';
import '../modules/login/view/login_view.dart';
import '../modules/onboarding/binding/onboarding_binding.dart';
import '../modules/onboarding/view/onboarding_view.dart';
import '../modules/otp/binding/otp_binding.dart';
import '../modules/otp/view/otp_view.dart';
import '../modules/premium/binding/premium_binding.dart';
import '../modules/premium/view/premium_view.dart';
import '../modules/splash/binding/splash_binding.dart';
import '../modules/splash/view/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_PROFILE,
      page: () => const CreateProfileView(),
      binding: CreateProfileBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeScreenView(),
      bindings: [HomeScreenBinding(), HomeBinding()],
    ),
    GetPage(
      name: _Paths.PREMIUM,
      page: () => const PremiumView(),
      binding: PremiumBinding(),
    ),
  ];
}
