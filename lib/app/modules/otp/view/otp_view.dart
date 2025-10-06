import 'package:femtor/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../controller/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({super.key});

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Enter the 6 digit code",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Sent to ${controller.contactInfo}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                  color: AppColors.textColor,
                ),
              ),
              const SizedBox(height: 30),
              _buildPinCodeFields(context),
              Obx(
                () => controller.hasError.value
                    ? Text(
                        "Invalid OTP entered!",
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      )
                    : const SizedBox.shrink(),
              ),
              const SizedBox(height: 2),
              GestureDetector(
                onTap: controller.resendOtp,
                child: RichText(
                  text: TextSpan(
                    text: "Didn't get a code? ",
                    style: const TextStyle(color: Colors.black54, fontSize: 14),
                    children: [
                      const TextSpan(
                        text: "Resend OTP",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),
              _buildVerifyButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPinCodeFields(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(15),
        fieldHeight: 50,
        fieldWidth: 45,
        activeFillColor: const Color(
          0xff944E63,
        ).withOpacity(0.1), // Field with value
        inactiveFillColor: const Color(0xFFF8F8F8), // Inactive field
        selectedFillColor: const Color(
          0xFFF8F8F8,
        ), // Active (currently focused) field
        activeColor: const Color(
          0xff944E63,
        ).withOpacity(0.2), // Field with value border
        inactiveColor: const Color(0xFFEEEEEE), // Inactive field border
        selectedColor: const Color(
          0xff944E63,
        ).withOpacity(0.2), // Active (currently focused) field border
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: AppColors.backgroundColor,
      enableActiveFill: true,
      keyboardType: TextInputType.number,
      controller: controller.otpController,
      onCompleted: (v) {
        print("Completed");
        // controller.verifyOtp();
      },
      onChanged: (value) {
        if (value.length < 6) {
          controller.hasError.value = false;
        }
        controller.isButtonEnabled.value = value.length == 6;
      },
      beforeTextPaste: (text) {
        return true;
      },
    );
  }

  Widget _buildVerifyButton() {
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
              ? controller.verifyOtp
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
            "Verify",
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
}
