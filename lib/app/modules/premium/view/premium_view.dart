import 'package:femtor/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/premium_controller.dart';

class PremiumView extends GetView<PremiumController> {
  const PremiumView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              Images.proScreenBgImage, // Replace with your actual image path
              fit: BoxFit.cover,
            ),
          ),

          // Main Content
          Positioned.fill(
            top:
                MediaQuery.of(context).size.height *
                0.48, // Start content from middle
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const Text(
                    "Become a Premium member",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Ad-free experience, Explore top Artists & courses\nAccess all courses, Cancel anytime",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 30),
                  _buildSubscriptionOption(
                    "₹ 49.00 / Week",
                    "1-day free trial",
                    0,
                  ),
                  const SizedBox(height: 16),
                  _buildSubscriptionOption(
                    "₹ 249.00 / Month",
                    "3-day free trial",
                    1,
                  ),
                  const SizedBox(height: 16),
                  _buildSubscriptionOption(
                    "₹ 999.00 / Year",
                    "Save 30%",
                    2,
                    isYearly: true,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green.shade600,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Cancel any time",
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  _buildContinueButton(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          // Close button
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.black),
              onPressed: () => Get.back(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionOption(
    String price,
    String trial,
    int index, {
    bool isYearly = false,
  }) {
    return Obx(() {
      final isSelected = controller.selectedIndex.value == index;
      return GestureDetector(
        onTap: () => controller.selectPlan(index),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primaryColor.withOpacity(0.1)
                : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? AppColors.primaryColor : Colors.grey.shade300,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                price,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (isYearly)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    trial,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              else
                Text(
                  trial,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildContinueButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.buttonGradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ElevatedButton(
        onPressed: controller.continueToPayment,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadowColor: Colors.transparent,
        ),
        child: const Text(
          "Continue",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
