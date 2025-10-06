import 'package:femtor/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controller/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.secondaryColor),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      controller.isUserInIndia.value
                          ? "Enter you"
                          : "Enter your",
                      style: const TextStyle(
                        fontSize: 24,
                        color: AppColors.textColor,
                      ),
                    ),
                    Text(
                      controller.isUserInIndia.value
                          ? " Mobile Number"
                          : " Email",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "to create your account",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w200,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 32),
                controller.isUserInIndia.value
                    ? _buildPhoneTextField(context)
                    : _buildEmailTextField(),
                const SizedBox(height: 8),
                Text(
                  controller.isUserInIndia.value
                      ? "We will send you an OTP on this number"
                      : "We will send you an OTP on this email",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textColor.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 24),
                _buildContinueButton(),
                const SizedBox(height: 32),
                _buildDivider(),
                const SizedBox(height: 32),
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
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneTextField(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          height: 55,
          decoration: BoxDecoration(
            color: Color(0xffF8F8F8),
            border: Border.all(color: Color(0xffEEEEEE)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              "+91",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              color: Color(0xffF8F8F8),
              border: Border.all(color: Color(0xffEEEEEE)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: TextField(
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,

                onChanged: (v) {
                  if (v.length == 10) {
                    FocusScope.of(context).unfocus();
                  }
                },
                decoration: InputDecoration(
                  hintText: "99099 99099",
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailTextField() {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.email_outlined, color: Colors.grey.shade600),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "Email Address",
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          gradient: controller.isButtonEnabled.value
              ? AppColors.buttonGradient
              : null,
          color: controller.isButtonEnabled.value ? null : Colors.grey.shade400,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ElevatedButton(
          onPressed: controller.isButtonEnabled.value
              ? controller.proceedToVerification
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            shadowColor: Colors.transparent,
            elevation: 0,
          ),
          child: const Text(
            "Continue",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Or continue with',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ),
        const Expanded(child: Divider()),
      ],
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
        text,
        style: const TextStyle(color: AppColors.secondaryColor),
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.secondaryColor,
        backgroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        elevation: 0,
      ),
    );
  }
}
