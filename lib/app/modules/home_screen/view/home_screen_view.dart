import 'package:femtor/app/utils/constants.dart';
import 'package:femtor/app/utils/event_bus_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../home_view/view/home_view.dart';
import '../controller/home_screen_controller.dart';

class HomeScreenView extends GetView<HomeScreenController> {
  const HomeScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: controller.pageController,
        onPageChanged: controller.onPageChanged,
        physics: NeverScrollableScrollPhysics(),
        children: const [
          HomeView(),
          Center(child: Text("Courses")),
          Center(child: Text("My Learning")),
          Center(child: Text("Profile")),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        alignment: Alignment.center,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Images.icHome, "Home", 0),
            _buildNavItem(Images.icSearch, "Courses", 1),
            _buildNavItem(Images.icContinueNav, "My Learning", 2),
            _buildNavItem(Images.icProfile, "Profile", 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String iconPath, String label, int index) {
    final isSelected = controller.selectedIndex.value == index;
    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
        EventBusHelper.instance.fire(NavigationEvent(index));
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor.withOpacity(0.1) : null,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(
                isSelected ? AppColors.primaryColor : Colors.grey.shade600,
                BlendMode.srcIn,
              ),
              height: 24,
            ),
            if (isSelected) const SizedBox(width: 8),
            if (isSelected)
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
