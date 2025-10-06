import 'package:femtor/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controller/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top section for animated text
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: controller.onboardingPages.length,
                onPageChanged: (index) {
                  controller.currentPage.value = index;
                },

                itemBuilder: (context, index) {
                  final item = controller.onboardingPages[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item['title']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Serif',
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        item['subtitle']!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textColor.withOpacity(0.7),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // Bottom section for login buttons
            Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Color(0XFFF1F1F1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Note: You will need to add the actual image assets for these buttons
                  _buildSocialButton(
                    'Continue with Apple',
                    Images.icAppleLogo,
                    onPressed: controller.signInWithApple,
                  ),
                  const SizedBox(height: 16),
                  _buildSocialButton(
                    'Continue with Google',
                    Images.icGoogleLogo,
                    onPressed: controller.signInWithGoogle,
                  ),
                  const SizedBox(height: 16),
                  const Text('Or', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 16),
                  Obx(
                    () => _buildPrimaryButton(
                      controller.isUserInIndia.value
                          ? 'Continue with phone number'
                          : 'Continue with email',
                      controller.isUserInIndia.value
                          ? Icons.phone_android
                          : Icons.email_outlined,
                      onPressed: controller.continueWithPhoneOrEmail,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Privacy Policy & Terms of Use',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton(
    String text,
    String iconPath, {
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      icon: SvgPicture.asset(
        iconPath,
        height: 20,
        width: 20,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      ),
      label: Text(
        text, // Example text
        style: TextStyle(color: AppColors.secondaryColor),
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.secondaryColor,
        backgroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
    );
  }

  Widget _buildPrimaryButton(
    String text,
    IconData icon, {
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.buttonGradient,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton.icon(
        icon: SvgPicture.asset(
          Images.icPhoneLogo,
          height: 20,
          width: 20,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
        ),
        label: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadowColor: Colors.transparent,
          elevation: 0,
        ),
      ),
    );
  }
}
